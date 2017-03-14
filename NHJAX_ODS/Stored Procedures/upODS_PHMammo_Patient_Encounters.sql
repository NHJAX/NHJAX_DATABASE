



CREATE PROCEDURE [dbo].[upODS_PHMammo_Patient_Encounters] AS

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

EXEC dbo.upActivityLog 'Begin PH Mammography Encounter',0,@day;


DECLARE	curMammoEnc CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PATIENT.PatientId,
	mammo.LastExamDate AS Appointmentdatetime,
	6 AS SourceSystemId	
FROM PATIENT
	INNER JOIN vwSTG_POP_HEALTH_MAMMOGRAPHY AS MAMMO 
	ON PATIENT.PatientIdentifier = MAMMO.EDIPN
WHERE     (isdate(mammo.LastExamDate) = 1)

OPEN curMammoEnc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Mammography Encounter',0
FETCH NEXT FROM curMammoEnc INTO @pat,@date,@src

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
			
			--SELECT @gen = LastNumber 
			--FROM GENERATOR
			SET @encnum = dbo.GenerateEncounterKey(@pat)

--print 'Patient Id: '@pat
--print '#chars: ' len(@pat)

		--COMMENT--
/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
 AS A STRING FOR THE ENCOUNTER KEY FIELD.*/


--SET @encstring = cast(cast(@pat as integer)as varchar(15)) + cast(rand()+1/rand(day(@date))as varchar(10))
--set @encstring = cast(cast(@pat/2 as integer) as varchar(15)) + cast(cast(@gen*1.25 as integer) as varchar(10))
--set @encnum = cast(substring(@encstring, 1, 9) as numeric(13,3))
--print 'Encounterkey: ' @encnum
--print '#chars: ' len(@encnum)
				INSERT INTO NHJAX_ODS.dbo.Patient_Encounter(
				PatientId,
				AppointmentDatetime,
				SourceSystemId,
				EncounterKey,
				AppointmentStatusId)
				VALUES(@pat,@date,@src,@encnum,2);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curMammoEnc INTO @pat,@date,@src
		
	COMMIT	
	END
END

CLOSE curMammoEnc
DEALLOCATE curMammoEnc

SET @sirow = 'PH Mammography Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Mammography Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Mammography Encounter',0,@day;
