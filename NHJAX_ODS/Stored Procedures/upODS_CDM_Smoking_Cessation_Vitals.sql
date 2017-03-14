

CREATE PROCEDURE [dbo].[upODS_CDM_Smoking_Cessation_Vitals] AS

Declare @enc bigint
Declare @tob varchar(50)

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

EXEC dbo.upActivityLog 'Begin CDM Smoking Cessation Vitals',0,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PE.PatientEncounterId,
	ISNULL(CESS.Tobacco,'') AS Tobacco
FROM vwSTG_SMOKING_CESSATION AS CESS
	INNER JOIN PATIENT_ENCOUNTER AS PE
	ON CESS.AppointmentId = PE.CDMAppointmentId

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM Smoking Cessation Vitals',0
FETCH NEXT FROM cur INTO @enc,@tob

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId
		FROM NHJAX_ODS.dbo.VITAL
		WHERE	PatientEncounterId = @enc
			AND VitalTypeId = 1
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.VITAL(
				VitalTypeId,
				PatientEncounterId,
				Result)
				VALUES(1,@enc,@tob);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @enc,@tob
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM Smoking Cessation Vitals Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM Smoking Cessation Vitals Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End CDM Smoking Cessation Vitals',0,@day;

PRINT @sirow
PRINT @strow