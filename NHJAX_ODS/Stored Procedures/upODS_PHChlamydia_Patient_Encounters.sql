



CREATE PROCEDURE [dbo].[upODS_PHChlamydia_Patient_Encounters] AS

Declare @pat bigint
Declare @date datetime
Declare @src bigint

Declare @patX bigint
Declare @dateX datetime
Declare @srcX bigint

Declare @gen bigint
Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int

Declare @encstring as varchar(25)
Declare @encnum as numeric(13,3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Chlamydia Encounter',0,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PATIENT.PatientId,
	CHLAM.[Last Exam Date] AS Appointmentdatetime,
	6 AS SourceSystemId	
FROM vwSTG_POP_HEALTH_CHLAMYDIA AS CHLAM
	INNER JOIN PATIENT 
	ON PATIENT.PatientIdentifier = CHLAM.EDIPN
WHERE (ISDATE(CHLAM.[Last Exam Date]) = 1)

OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Chlamydia Encounter',0
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

				--COMMENT--
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

SET @sirow = 'PH Chlamydia Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Chlamydia Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Chlamydia Encounter',0,@day;
