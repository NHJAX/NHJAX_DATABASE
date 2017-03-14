

CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Vitals] AS

Declare @enc bigint
Declare @ins varchar(50)

Declare @encX bigint
Declare @insX varchar(50)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Diabetes Vitals',0,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PE.PatientEncounterId,
	DIAB.Insulin
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIAB 
	ON PATIENT.Patientidentifier = DIAB.EDIPN  
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIAB.A1CDate = PE.AppointmentDateTime
WHERE (DIAB.Insulin IS NOT NULL)

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch PH Diabetes Vitals',0
FETCH NEXT FROM cur INTO @enc,@ins

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.VITAL
		WHERE	PatientEncounterId = @enc
			AND VitalTypeId = 3
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.VITAL(
				VitalTypeId,
				PatientEncounterId,
				Result)
				VALUES(3,@enc,@ins);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@ins
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH Diabetes Vitals Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Diabetes Vitals Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Diabetes Vitals',0,@day;

PRINT @sirow
PRINT @strow