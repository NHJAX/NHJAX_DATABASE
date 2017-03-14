
CREATE PROCEDURE [dbo].[upODS_M2_Patient_Procedures] AS

Declare @cpt bigint
Declare @enc bigint
Declare @type bigint
Declare @diag decimal
Declare @date datetime
Declare @desc varchar(60)
Declare @rvu money
Declare @src bigint

Declare @prX bigint
Declare @cptX bigint
Declare @encX bigint
Declare @typeX bigint
Declare @diagX decimal
Declare @dateX datetime
Declare @descX varchar(60)
Declare @rvuX money
Declare @srcX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

--Declare @encstring as varchar(25)
--Declare @encnum as numeric(13,3)

EXEC dbo.upActivityLog 'Begin M2 Patient Procedure',0,@day;


DECLARE	curM2Enc CURSOR FAST_FORWARD FOR 
SELECT     
	CPT.CptId, 
	ENC.PatientEncounterId, 
	1 AS ProcedureTypeId, 
	1 AS DiagnosisPriorities, 
	PROD.[Service Date], 
	CPT.CptDesc, 
	PROD.[Procedure 1 RVU], 
	7 AS SourceSystemId
FROM	vwSTG_PRODUCTIVITY AS PROD 
	INNER JOIN CPT 
	ON PROD.[Procedure 1] = CPT.CptCode 
	LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC 
	ON PROD.[Record ID] = ENC.PatientAppointmentKey
WHERE	(DataLength(PROD.[Procedure 1]) > 0) 
	AND (ENC.SourceSystemId = 7)
UNION 
SELECT	
	CPT.CptId, 
	ENC.PatientEncounterId, 
	1 AS ProcedureTypeId, 
	2 AS DiagnosisPriorities, 
	PROD.[Service Date], 
	CPT.CptDesc, 
	PROD.[Procedure 2 RVU], 
	7 AS SourceSystemId
FROM         
	vwSTG_PRODUCTIVITY AS PROD 
	INNER JOIN CPT 
	ON PROD.[Procedure 2] = CPT.CptCode 
	LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC 
	ON PROD.[Record ID] = ENC.PatientAppointmentKey
WHERE	(DataLength(PROD.[Procedure 2]) > 0) 
	AND (ENC.SourceSystemId = 7)
UNION 
SELECT	
	CPT.CptId, 
	ENC.PatientEncounterId, 
	1 AS ProcedureTypeId, 
	3 AS DiagnosisPriorities, 
	PROD.[Service Date], 
	CPT.CptDesc, 
	PROD.[Procedure 3 RVU], 
	7 AS SourceSystemId
FROM         
	vwSTG_PRODUCTIVITY AS PROD 
	INNER JOIN CPT 
	ON PROD.[Procedure 3] = CPT.CptCode 
	LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC 
	ON PROD.[Record ID] = ENC.PatientAppointmentKey
WHERE	(DataLength(PROD.[Procedure 3]) > 0) 
	AND (ENC.SourceSystemId = 7)
UNION 
SELECT	
	CPT.CptId, 
	ENC.PatientEncounterId, 
	1 AS ProcedureTypeId, 
	4 AS DiagnosisPriorities, 
	PROD.[Service Date], 
	CPT.CptDesc, 
	PROD.[Procedure 4 RVU], 
	7 AS SourceSystemId
FROM         
	vwSTG_PRODUCTIVITY AS PROD 
	INNER JOIN CPT 
	ON PROD.[Procedure 4] = CPT.CptCode 
	LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC 
	ON PROD.[Record ID] = ENC.PatientAppointmentKey
WHERE	(DataLength(PROD.[Procedure 4]) > 0) 
	AND (ENC.SourceSystemId = 7)
UNION 
SELECT	
	CPT.CptId, 
	ENC.PatientEncounterId, 
	2 AS ProcedureTypeId, 
	0 AS DiagnosisPriorities, 
	PROD.[Service Date], 
	CPT.CptDesc, 
	PROD.[E&M Procedure RVU], 
	7 AS SourceSystemId
FROM         
	vwSTG_PRODUCTIVITY AS PROD 
	INNER JOIN CPT 
	ON PROD.[E&M Code] = CPT.CptCode 
	LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC 
	ON PROD.[Record ID] = ENC.PatientAppointmentKey
WHERE	(DataLength(PROD.[E&M Code]) > 0) 
	AND (ENC.SourceSystemId = 7)

OPEN curM2Enc
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch M2 Patient Procedure',0
FETCH NEXT FROM curM2Enc INTO @cpt,@enc,@type,@diag,@date,@desc,@rvu,@src

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@prX = ProcedureId
		FROM NHJAX_ODS.dbo.PATIENT_PROCEDURE
		WHERE PatientEncounterId = @enc
		AND CptId = @cpt
		AND SourceSystemId = 7
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN

				--PRINT @appt
				--PRINT @pat
				--PRINT @enc

				INSERT INTO NHJAX_ODS.dbo.PATIENT_PROCEDURE(
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				DiagnosisPriorities,
				ProcedureDateTime,
				ProcedureDesc,
				RVU,
				SourceSystemId)
				VALUES(@cpt,@enc,@type,@diag,@date,
				@desc,@rvu,@src);
				SET @irow = @irow + 1	

			END
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curM2Enc INTO @cpt,@enc,@type,@diag,
			@date,@desc,@rvu,@src
		
	COMMIT	
	END
END

CLOSE curM2Enc
DEALLOCATE curM2Enc

SET @sirow = 'M2 Patient Procedure Inserted: ' + CAST(@irow AS varchar(50))
--SET @surow = 'M2 Patient Encounter Updated: ' + CAST(@urow AS varchar(50))
SET @strow = 'M2 Patient Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
--EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End M2 Patient Procedure',0,@day;
