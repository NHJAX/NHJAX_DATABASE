
CREATE PROCEDURE [dbo].[upODS_CDM_IMMUNIZATIONS_ICD] AS

Declare @enc bigint
Declare @diag bigint
Declare @desc varchar(500)

Declare @encX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin CDM Immunization ICD',3,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PE.PatientEncounterId,
	DIAG.DiagnosisId,
	IMM.ImmunizationVaccineName
FROM vwSTG_IMMUNIZATIONS AS IMM
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON IMM.CDMAppointmentId = PE.CDMAppointmentId
	AND IMM.PatientId = PE.PatientId
	AND IMM.ImmunizationDate = PE.AppointmentDateTime
	INNER JOIN DIAGNOSIS AS DIAG
	ON IMM.ImmunizationCode = REPLACE(DIAG.DiagnosisCode,'.','')
WHERE IMM.ImmunizationTypeId = 1

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM Immunizations ICD',3
FETCH NEXT FROM cur INTO @enc,@diag,@desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS
		WHERE	PatientEncounterId = @enc
			AND DiagnosisId = @diag
			AND Description = @desc
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS(
				PatientEncounterId,
				DiagnosisId,
				Priority,
				[Description],
				SourceSystemId)
				VALUES(@enc,@diag,1,@desc,11);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@diag,@desc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM Immunizations ICD Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM Immunizations ICD Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,3;
EXEC dbo.upActivityLog @strow,3;
EXEC dbo.upActivityLog 'End CDM Immunizations ICD',3,@day;

PRINT @sirow
PRINT @strow