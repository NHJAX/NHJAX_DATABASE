
CREATE PROCEDURE [dbo].[upODS_AHLTACervical_Patient_Diagnosis] AS

Declare @icd bigint
Declare @enc bigint
declare @desc varchar(60)

Declare @icdX bigint
Declare @encX bigint
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

EXEC dbo.upActivityLog 'Begin AHLTA Cervical Diagnosis',0,@day;

DECLARE	curProc CURSOR FAST_FORWARD FOR 
SELECT DISTINCT  
	ICD.DiagnosisId, 
	PE.PatientEncounterId, 
	ICD.DiagnosisDesc
FROM vwSTG_AHLTA_CERVICAL_ICD9 AS CERV
	INNER JOIN vwODS_PATIENT_FMP AS PFMP 
	ON CERV.SponsorSSN = PFMP.SponsorSSN 
	AND CERV.FMP = PFMP.FamilyMemberPrefixKey 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PFMP.PatientId = PE.PatientId 
	AND CERV.[Appointment Id] = PE.PatientAppointmentKey 
	INNER JOIN DIAGNOSIS AS ICD ON CERV.[ICD9 Code] = ICD.DiagnosisCode
WHERE (PE.SourceSystemId = 11)

OPEN curProc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch AHLTA Cervical Diagnosis',0
FETCH NEXT FROM curProc INTO @icd,@enc,@desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@icdX = DiagnosisId,
				@encX = PatientEncounterId,
				@descX = [Description]
		FROM NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS
		WHERE	PatientEncounterId = @enc
			AND DiagnosisId = @icd
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS
				(
				DiagnosisId,
				PatientEncounterId,
				[Description],
				SourceSystemId
				)
				VALUES(@icd,@enc,@desc,11);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curProc INTO @icd,@enc,@desc
		
	COMMIT	
	END
END

CLOSE curProc
DEALLOCATE curProc

SET @sirow = 'AHLTA Cervical Diagnosis Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'AHLTA Cervical Diagnosis Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End AHLTA Cervical Diagnosis',0,@day;



