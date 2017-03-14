



CREATE PROCEDURE [dbo].[upODS_PHCervical_Patient_Encounters] AS

Declare @pat bigint
Declare @date datetime
Declare @date2 datetime
Declare @date3 datetime

Declare @patX bigint
Declare @dateX datetime

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

EXEC dbo.upActivityLog 'Begin PH Cervical Encounter',0,@day;


DECLARE	curEnc CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PAT.PatientId, 
	CERV.PapLastExamDate,
	CERV.HpvLastExamDate,
	CERV.XLastExamDate
FROM vwSTG_POP_HEALTH_CERVICAL AS CERV 
	INNER JOIN vwODS_PATIENT AS PAT 
	ON CERV.EDIPN = PAT.PatientIdentifier
WHERE (isdate(CERV.PapLastExamDate) = 1)

OPEN curEnc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Cervical Encounter',0
FETCH NEXT FROM curEnc INTO @pat,@date,@date2,@date3

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		IF(@date2 > @date)
		BEGIN
			SET @date = @date2
		END
	
		Select 	@patX = PatientId,
				@dateX = AppointmentDatetime
		FROM NHJAX_ODS.dbo.Patient_Encounter
		WHERE	PatientId = @pat
			AND SourceSystemId = 6
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
--SET @encstring = cast(cast(@pat as integer) as varchar(15)) + cast(@gen as varchar(10))
--SET @encnum = CAST(@encstring AS numeric(13,3)) 
--print 'Encounterkey: ' @encnum
--print '#chars: ' len(@encnum)
				INSERT INTO NHJAX_ODS.dbo.Patient_Encounter(
				PatientId,
				AppointmentDatetime,
				SourceSystemId,
				EncounterKey,
				AppointmentStatusId)
				VALUES(@pat,@date,6,@encnum,2);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curEnc INTO @pat,@date,@date2,@date3
		
	COMMIT	
	END
END

CLOSE curEnc
DEALLOCATE curEnc

SET @sirow = 'PH Cervical Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Cervical Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Cervical Encounter',0,@day;

PRINT @sirow
PRINT @strow