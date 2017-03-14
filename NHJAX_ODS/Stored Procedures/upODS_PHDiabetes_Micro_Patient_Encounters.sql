
CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Micro_Patient_Encounters] AS

Declare @pat bigint
Declare @date datetime
Declare @src bigint

Declare @patX bigint
Declare @dateX datetime
Declare @srcX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int

Declare @encstring as varchar(25)
Declare @encnum as numeric(13,3)
Declare @gen bigint
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Diabetes Micro Encounter',0,@day;


DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT 
	PATIENT.PatientId,
	DIAB.testDate AS Appointmentdatetime,
	6 AS SourceSystemId			
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES_MICROALBUMINS AS DIAB 
	ON PATIENT.PatientIdentifier = DIAB.EDIPN
WHERE (ISDATE(DIAB.testDate) = 1)
AND	Result IS NOT NULL

OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Diabetes Micro Encounter',0
FETCH NEXT FROM cur INTO @pat,@date,@src

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@dateX = AppointmentDatetime,
				@srcX = SourceSystemId
		FROM NHJAX_ODS.dbo.Patient_Encounter
		WHERE	PatientId = @pat
			AND SourceSystemId = @src
			AND AppointmentDatetime = @date
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

				UPDATE GENERATOR SET LastNumber=LastNumber+1
				WHERE GeneratorTypeId = 1
				
				SET @encnum = dbo.GenerateEncounterKey(@pat)

				--COMMENT------------------
				/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
				AS A STRING FOR THE ENCOUNTER KEY FIELD.*/

				INSERT INTO NHJAX_ODS.dbo.Patient_Encounter(
				PatientId,
				AppointmentDatetime,
				SourceSystemId,
				EncounterKey)
				VALUES(@pat,@date,@src,@encnum);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@date,@src
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH Diabetes Micro Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Diabetes Micro Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Diabetes Micro Encounter',0,@day;
