

CREATE PROCEDURE [dbo].[upODS_CDM_BMI_Vitals] AS

Declare @enc bigint
Declare @bmi varchar(50)

Declare @encX bigint
Declare @tobX varchar(50)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin CDM BMI Vitals',0,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PE.PatientEncounterId,
	CAST(ISNULL(BMI.BMI,'') AS varchar(50)) AS BMI
FROM vwSTG_BMI AS BMI
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON BMI.AppointmentId = PE.CDMAppointmentId


OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM BMI Vitals',0
FETCH NEXT FROM cur INTO @enc,@bmi

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.VITAL
		WHERE	PatientEncounterId = @enc
			AND VitalTypeId = 2
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.VITAL(
				VitalTypeId,
				PatientEncounterId,
				Result)
				VALUES(2,@enc,@bmi);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@bmi
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM BMI Vitals Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM BMI Vitals Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End CDM BMI Vitals',0,@day;

PRINT @sirow
PRINT @strow

--Repeat for weight lbs
EXEC dbo.upActivityLog 'Begin CDM LBS Vitals',0,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PE.PatientEncounterId,
	CAST(ISNULL(BMI.[WeightLbs],'') AS varchar(50)) AS WeightLbs
FROM vwSTG_BMI AS BMI
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON BMI.AppointmentId = PE.CDMAppointmentId


OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM LBS Vitals',0
FETCH NEXT FROM cur INTO @enc,@bmi

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.VITAL
		WHERE	PatientEncounterId = @enc
			AND VitalTypeId = 4
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.VITAL(
				VitalTypeId,
				PatientEncounterId,
				Result)
				VALUES(4,@enc,@bmi);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@bmi
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM LBS Vitals Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM LBS Vitals Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End CDM LBS Vitals',0,@day;