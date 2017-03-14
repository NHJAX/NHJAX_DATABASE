
CREATE PROCEDURE [dbo].[upODS_CDM_IMMUNIZATIONS_CPT] AS

Declare @enc bigint
Declare @cpt bigint
Declare @desc varchar(500)
Declare @dt datetime

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

EXEC dbo.upActivityLog 'Begin CDM Immunization CPT',3,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PE.PatientEncounterId,
	ISNULL(CPT.CptId,20167),
	IMM.ImmunizationVaccineName,
	IMM.ImmunizationDate
FROM vwSTG_IMMUNIZATIONS AS IMM
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON IMM.CDMAppointmentId = PE.CDMAppointmentId
	AND IMM.PatientId = PE.PatientId
	AND IMM.ImmunizationDate = PE.AppointmentDateTime
	LEFT JOIN CPT
	ON IMM.ImmunizationCode = CPT.CptCode
WHERE IMM.ImmunizationTypeId = 2

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM Immunizations CPT',3
FETCH NEXT FROM cur INTO @enc,@cpt,@desc,@dt

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.PATIENT_PROCEDURE
		WHERE	PatientEncounterId = @enc
			AND CptId = @cpt
			AND ProcedureDesc = @desc
			AND ProcedureDateTime = @dt
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.PATIENT_PROCEDURE(
				PatientEncounterId,
				CptId,
				ProcedureDateTime,
				ProcedureDesc,
				ProcedureTypeId,
				SourceSystemId)
				VALUES(@enc,@cpt,@dt,@desc,5,11);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@cpt,@desc,@dt
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM Immunizations CPT Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM Immunizations CPT Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,3;
EXEC dbo.upActivityLog @strow,3;
EXEC dbo.upActivityLog 'End CDM Immunizations CPT',3,@day;

PRINT @sirow
PRINT @strow