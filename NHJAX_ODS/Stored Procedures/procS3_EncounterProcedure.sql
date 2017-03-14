
CREATE PROCEDURE [dbo].[procS3_EncounterProcedure] AS

Declare @id bigint
Declare @key numeric(14,3)
Declare @svc int
Declare @apt datetime
Declare @typ int
Declare @cpt bigint
Declare @rvu money
Declare @sur bigint
Declare @ane bigint
Declare @ser varchar(25)

Declare @rvuX money

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)

Declare @fromDate datetime
Declare @tempDate datetime 

Declare @exists int
Declare @day int

SET @tempDate = DATEADD(d,-90,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate);

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin S3 Encounter Procedures',0,@day;

DECLARE curS3 CURSOR FAST_FORWARD FOR
SELECT  DISTINCT 
	ENC.PatientEncounterId, 
	ENC.EncounterKey, 
	SVC.ServiceID, 
	ENC.AppointmentDateTime, 
	SERVICE_TYPE.ServiceTypeId, 
	ISNULL(CPT1.CptId, CPT2.CptId) AS CptId, 
    ISNULL(CPT1.RVU, 0) AS RVU,
    SERVICE_TYPE.ServiceTypeDesc
FROM PATIENT_ENCOUNTER AS ENC 
	INNER JOIN [NHJAX-DB-S3].AORS.dbo.Service AS SVC 
	ON ENC.EncounterKey = SVC.PatientID 
	INNER JOIN [NHJAX-DB-S3].AORS.dbo.ORProc AS ORProc 
	ON SVC.ServiceID = ORProc.ServiceID 
	INNER JOIN [NHJAX-DB-S3].AORS.dbo.LUProcedure AS S3Proc 
	ON ORProc.LUProcedureID = S3Proc.LUProcedureID 
	INNER JOIN SERVICE_TYPE 
	ON SVC.Service = SERVICE_TYPE.ServiceTypeDesc 
	LEFT OUTER JOIN CPT AS CPT2 
	ON S3Proc.LUProcedureID = CPT2.CptHcpcsKey 
	AND CPT2.SourceSystemId = 10 
	LEFT OUTER JOIN CPT AS CPT1 
	ON CAST(S3Proc.DefCPT AS varchar(30)) = CPT1.CptCode
WHERE (ENC.SourceSystemId = 10) 
	AND ISNULL(CPT1.CptId, CPT2.CptId) IS NOT NULL
	--AND (ENC.AppointmentDateTime > '2004-01-01')
	AND (ENC.AppointmentDateTime > @fromDate)
	--AND (ENC.EncounterKey = 29976)

OPEN curS3
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch S3 Encounter Procedures',0
FETCH NEXT FROM curS3 INTO @id,@key,@svc,@apt,@typ,@cpt,@rvu,@ser

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
		--Determin Surgeon/Anes
		SET @ane = 0
		SELECT @ane = PROVIDER.ProviderId
		FROM PROVIDER 
		INNER JOIN [NHJAX-DB-S3].AORS.dbo.AnesStaff AS ANES 
		ON PROVIDER.SourceSystemKey = ANES.LUAnesStaffID
		WHERE (ANES.PatientID = @key)
		
		SET @sur = 0
		SELECT @sur = PROVIDER.ProviderId
		FROM PROVIDER 
		INNER JOIN [NHJAX-DB-S3].AORS.dbo.SurgicalStaff AS SURG 
		ON PROVIDER.SourceSystemKey = SURG.LUSurgicalStaffID
		WHERE (SURG.ServiceID = @svc)
				
		Select 	@rvuX = RVU
		FROM PATIENT_PROCEDURE
		WHERE PatientEncounterId = @id
		AND CptId = @cpt
		AND SourceSystemId IN (10)
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN

				INSERT INTO PATIENT_PROCEDURE(
				ProcedureKey,
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				ProcedureDateTime,
				SurgeonId,
				AnesthetistId,
				ProcedureDesc,
				RVU,
				ServiceTypeId,
				SourceSystemId)
				VALUES(
				@key,@cpt,@id,3,@apt,@sur,@ane,@ser,@rvu,@typ,10);
				
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

			IF	@rvu <> @rvuX
			OR	(@rvu Is Not Null AND @rvuX Is Null)
			BEGIN
				UPDATE PATIENT_PROCEDURE
				SET RVU = @rvu,
					UpdatedDate = GETDATE()
				WHERE PatientEncounterId = @id
					AND CptId = @cpt
					AND SourceSystemId IN (10);
					
				SET @urow = @urow + 1
			END
						
		END
		SET @trow = @trow + 1

		FETCH NEXT FROM curS3 INTO @id,@key,@svc,@apt,@typ,@cpt,@rvu,@ser
			
	COMMIT
	END

END
CLOSE curS3
DEALLOCATE curS3

SET @surow = 'S3 Encounter Procedures Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'S3 Encounter Procedures Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'S3 Encounter Procedures: ' + CAST(@drow AS varchar(50))
SET @strow = 'S3 Encounter Procedures Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End S3 Encounter Procedures',0,@day;