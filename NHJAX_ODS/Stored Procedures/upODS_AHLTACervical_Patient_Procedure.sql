
CREATE PROCEDURE [dbo].[upODS_AHLTACervical_Patient_Procedure] AS

Declare @cpt bigint
Declare @enc bigint
declare @proc bigint 
Declare @date datetime
declare @desc varchar(60)

Declare @cptX bigint
Declare @encX bigint
declare @procX bigint 
Declare @dateX datetime
declare @descX varchar(60)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin AHLTA Cervical Procedure',0,@day;

DECLARE	curProc CURSOR FAST_FORWARD FOR 
SELECT DISTINCT  
	CPT.CptId, 
	PE.PatientEncounterId, 
	CPT.CptTypeId, 
	PE.AppointmentDateTime, 
	CPT.CptDesc
FROM vwSTG_AHLTA_CERVICAL_CPT AS CERV
	INNER JOIN vwODS_PATIENT_FMP AS PFMP 
	ON CERV.SponsorSSN = PFMP.SponsorSSN 
	AND CERV.FMP = PFMP.FamilyMemberPrefixKey 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PFMP.PatientId = PE.PatientId 
	AND CERV.[Appointment Id] = PE.PatientAppointmentKey 
	INNER JOIN CPT ON CERV.[CPT4 Code] = CPT.CptCode
WHERE (PE.SourceSystemId = 11)

OPEN curProc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch AHLTA Cervical Procedure',0
FETCH NEXT FROM curProc INTO @cpt,@enc,@proc,@date,@desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@cptX = CPTId,
				@encX = PatientEncounterId,
				@procX = ProcedureTypeId,
				@dateX = ProcedureDatetime,
				@descX = ProcedureDesc
		FROM NHJAX_ODS.dbo.Patient_Procedure
		WHERE	patientencounterid = @enc
			AND CptId = @cpt
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.Patient_Procedure(
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				ProcedureDateTime,
				ProcedureDesc,
				SourceSystemId
				)
				VALUES(@cpt,@enc,@proc,@date,@desc,11);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curProc INTO @cpt,@enc,@proc,@date,@desc
		
	COMMIT	
	END
END

CLOSE curProc
DEALLOCATE curProc

SET @sirow = 'AHLTA Cervical Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'AHLTA Cervical Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End AHLTA Cervical Procedure',0,@day;



