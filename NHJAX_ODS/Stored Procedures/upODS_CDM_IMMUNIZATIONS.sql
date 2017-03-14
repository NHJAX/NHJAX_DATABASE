
CREATE PROCEDURE [dbo].[upODS_CDM_IMMUNIZATIONS] AS

Declare @enc bigint
Declare @vac varchar(255)
Declare @dt datetime
Declare @due datetime
Declare @ser float
Declare @ex varchar(50)
Declare @exd datetime
Declare @dos varchar(50)
Declare @lot varchar(50)
Declare @cd bigint
Declare @typ int
Declare @man bigint

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

EXEC dbo.upActivityLog 'Begin CDM Immunization',3,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PE.PatientEncounterId,
	IMM.ImmunizationVaccineName,
	IMM.ImmunizationDate,
	IMM.ImmunizationDateNextDue,
	IMM.ImmunizationSeries,
	IMM.ImmunizationExemption,
	IMM.ImmunizationExemptionExpirDate,
	IMM.ImmunizationDosage,
	IMM.ImmunizationLotNumber,
	ISNULL(CPT.CptId,20167),
	IMM.ImmunizationTypeId,
	ISNULL(MAN.ImmunizationManufacturerId,19)
FROM vwSTG_IMMUNIZATIONS AS IMM
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON IMM.CDMAppointmentId = PE.CDMAppointmentId
	AND IMM.PatientId = PE.PatientId
	AND IMM.ImmunizationDate = PE.AppointmentDateTime
	LEFT OUTER JOIN IMMUNIZATION_MANUFACTURER AS MAN
	ON IMM.ImmunizationManufacturer = MAN.ImmunizationManufacturerDesc
	LEFT OUTER JOIN CPT
	ON IMM.ImmunizationCode = CPT.CptCode
WHERE IMM.ImmunizationTypeId = 2
UNION
SELECT DISTINCT
	PE.PatientEncounterId,
	IMM.ImmunizationVaccineName,
	IMM.ImmunizationDate,
	IMM.ImmunizationDateNextDue,
	IMM.ImmunizationSeries,
	IMM.ImmunizationExemption,
	IMM.ImmunizationExemptionExpirDate,
	IMM.ImmunizationDosage,
	IMM.ImmunizationLotNumber,
	DIAG.DiagnosisId,
	IMM.ImmunizationTypeId,
	ISNULL(MAN.ImmunizationManufacturerId,19)
FROM vwSTG_IMMUNIZATIONS AS IMM
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON IMM.CDMAppointmentId = PE.CDMAppointmentId
	AND IMM.PatientId = PE.PatientId
	AND IMM.ImmunizationDate = PE.AppointmentDateTime
	LEFT OUTER JOIN IMMUNIZATION_MANUFACTURER AS MAN
	ON IMM.ImmunizationManufacturer = MAN.ImmunizationManufacturerDesc
	INNER JOIN DIAGNOSIS AS DIAG
	ON IMM.ImmunizationCode = REPLACE(DIAG.DiagnosisCode,'.','')
WHERE IMM.ImmunizationTypeId = 1


OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM Immunization',3
FETCH NEXT FROM cur INTO @enc,@vac,@dt,@due,@ser,@ex,@exd,@dos,@lot,@cd,@typ,@man

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.AHLTA_IMMUNIZATION
		WHERE	PatientEncounterId = @enc
			AND ImmunizationVaccineName = @vac
			AND ImmunizationDate = @dt
			AND ImmunizationCodeId = @cd
			AND ImmunizationTypeId = @typ
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.AHLTA_IMMUNIZATION
				(
				PatientEncounterId, 
				ImmunizationVaccineName, 
				ImmunizationDate, 
				ImmunizationDateNextDue, 
				ImmunizationSeries, 
				ImmunizationExemption, 
                ImmunizationExemptionExpireDate, 
                ImmunizationDosage, 
                ImmunizationLotNumber, 
                ImmunizationCodeId, 
                ImmunizationTypeId, 
                ImmunizationManufacturerId
                )
				VALUES
				(
				@enc,@vac,@dt,@due,@ser,@ex,
				@exd,@dos,@lot,@cd,@typ,@man
				);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@vac,@dt,@due,@ser,@ex,@exd,@dos,@lot,@cd,@typ,@man
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM Immunization Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM Immunization Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,3;
EXEC dbo.upActivityLog @strow,3;
EXEC dbo.upActivityLog 'End CDM Immunization',3,@day;

PRINT @sirow
PRINT @strow