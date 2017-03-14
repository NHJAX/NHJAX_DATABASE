
CREATE PROCEDURE [dbo].[upODS_PHColorectal_Patient_Encounters] AS

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

EXEC dbo.upActivityLog 'Begin PH Colon Cancer Encounter',0,@day;

DECLARE	curCOL CURSOR FAST_FORWARD FOR 
--GETS COLONOSCOPY ENCOUNTERS AND ADDS THEM TO ENCOUNTERS TABLE
SELECT DISTINCT
	PATIENT.PatientId,
	colon.COLONOSCOPYDATE AS Appointmentdatetime,
	6 AS SourceSystemId
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_COLON AS COLON 
	ON PATIENT.PatientIdentifier = COLON.EDIPN
WHERE (isdate(COLON.COLONOSCOPYDATE) = 1)

OPEN curCOL
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Colon Cancer Encounter',0
FETCH NEXT FROM curCOL INTO @pat,@date,@src

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
--set @encstring = cast(cast(@pat/2 as integer) as varchar(15)) + cast(cast(@gen/2 as integer) as varchar(10))
--set @encnum = cast(substring(@encstring, 1, 9) as numeric(13,3)) 
--print 'Encounterkey: ' + @encnum
--print '#chars: ' + len(@encnum)
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
		FETCH NEXT FROM curCOL INTO @pat,@date,@src
		
	COMMIT	
	END
END

CLOSE curCOL
DEALLOCATE curCOL

SET @sirow = 'PH Colon Cancer Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Colon Cancer Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--********************************************************************************************************************
DECLARE	curSIG CURSOR FAST_FORWARD FOR 
--GETS FLEX SIGMOIDOSCOPY ENCOUNTERS AND ADDS THEM TO ENCOUNTERS TABLE
SELECT DISTINCT
	PATIENT.PatientId,
	colon.FLEXSIGMOIDDATE AS Appointmentdatetime,
	6 AS SourceSystemId
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_COLON AS COLON 
	ON PATIENT.PatientIdentifier = COLON.EDIPN
WHERE (isdate(COLON.FLEXSIGMOIDDATE) = 1)

OPEN curSIG
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Colon Cancer Sig Encounter',0
FETCH NEXT FROM curSIG INTO @pat,@date,@src

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

			--SELECT @gen = LastNumber 
			--FROM GENERATOR
			SET @encnum = dbo.GenerateEncounterKey(@pat)

--print 'Patient Id: '@pat
--print '#chars: ' len(@pat)

		--COMMENT--
/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
 AS A STRING FOR THE ENCOUNTER KEY FIELD.*/


--SET @encstring = cast(cast(@pat as integer)as varchar(15)) + cast(rand()+1/rand(day(@date))as varchar(10))
--SET @encstring = cast(cast(@pat as integer) as varchar(15)) + cast(@gen as varchar(15))
--SET @encnum = CAST(@encstring AS numeric(18,3)) 
--print 'Encounterkey: ' + @encnum
--print '#chars: ' + len(@encnum)
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
		FETCH NEXT FROM curSIG INTO @pat,@date,@src
		
	COMMIT	
	END
END

CLOSE curSIG
DEALLOCATE curSIG

SET @sirow = 'PH Colon Cancer Sig Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Colon Cancer Sig Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;


--**********************************************************************************************************************
--DECLARE	curFOBT CURSOR FAST_FORWARD FOR 
----GETS FLEX FOBT ENCOUNTERS AND ADDS THEM TO ENCOUNTERS TABLE
--SELECT DISTINCT
--	PATIENT.PatientId,
--	colon.FOBTdate AS Appointmentdatetime,
--	6 AS SourceSystemId
--FROM vwMDE_FAMILY_MEMBER_PREFIX AS FMP 
--	INNER JOIN vwMDE_PATIENT AS PAT 
--	ON FMP.KEY_FAMILY_MEMBER_PREFIX = PAT.FMP_IEN 
--	INNER JOIN vwSTG_POP_HEALTH_COLON AS COLON 
--	ON FMP.FMP = COLON.FMP 
--	AND PAT.SPONSOR_SSN = dbo.FormattedSSN(COLON.SponsorSSN)
--	INNER JOIN PATIENT 
--	ON PAT.KEY_PATIENT = PATIENT.PatientKey
--WHERE (isdate(COLON.FOBTDate) = 1)

--OPEN curFOBT
--SET @trow = 0
--SET @irow = 0
--EXEC dbo.upActivityLog 'Fetch PH Colon Cancer FOBT Encounter',0
--FETCH NEXT FROM curFOBT INTO @pat,@date,@src

--if(@@FETCH_STATUS = 0)
--BEGIN
--	WHILE(@@FETCH_STATUS = 0)
--	BEGIN
--	BEGIN TRANSACTION
--		Select 	@patX = PatientId,
--				@dateX = AppointmentDatetime,
--				@srcX = SourceSystemId
--		FROM NHJAX_ODS.dbo.Patient_Encounter
--		WHERE	PatientId = @pat
--			AND SourceSystemId = @src
--			AND AppointmentDatetime = @date
--		SET		@exists = @@RowCount
--		If		@exists = 0 
			
--			BEGIN
			
--			UPDATE GENERATOR SET LastNumber=LastNumber+1

--			--SELECT @gen = LastNumber 
--			--FROM GENERATOR
--			SET @encnum = dbo.GenerateEncounterKey(@pat)

----print 'Patient Id: '@pat
----print '#chars: ' len(@pat)

--		--COMMENT--
--/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
-- AS A STRING FOR THE ENCOUNTER KEY FIELD.*/


----SET @encstring = cast(cast(@pat as integer)as varchar(15)) + cast(rand()+1/rand(day(@date))as varchar(10))
----SET @encstring = cast(cast(@pat as integer) as varchar(15)) + cast(@gen as varchar(15))
----SET @encnum = CAST(@encstring AS numeric(18,3)) 
----print 'Encounterkey: ' + @encnum
----print '#chars: ' + len(@encnum)
--				INSERT INTO NHJAX_ODS.dbo.Patient_Encounter(
--				PatientId,
--				AppointmentDatetime,
--				SourceSystemId,
--				EncounterKey)
--				VALUES(@pat,@date,@src,@encnum);
--				SET @irow = @irow + 1
--			END
	
--		SET @trow = @trow + 1
--		FETCH NEXT FROM curFOBT INTO @pat,@date,@src
		
--	COMMIT	
--	END
--END

--CLOSE curFOBT
--DEALLOCATE curFOBT

--SET @sirow = 'PH Colon Cancer FOBT Encounter Inserted: ' + CAST(@irow AS varchar(50))
--SET @strow = 'PH Colon Cancer FOBT Encounter Total: ' + CAST(@trow AS varchar(50))
----
--EXEC dbo.upActivityLog @sirow,0;
--EXEC dbo.upActivityLog @strow,0;

--*********************************************************************************************************
DECLARE	curDCBE CURSOR FAST_FORWARD FOR 
--GETS FLEX DCBE ENCOUNTERS AND ADDS THEM TO ENCOUNTERS TABLE
SELECT DISTINCT
	PATIENT.PatientId,
	colon.DCBEdate AS Appointmentdatetime,
	6 AS SourceSystemId
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_COLON AS COLON 
	ON PATIENT.PatientIdentifier = COLON.EDIPN
WHERE (isdate(COLON.DCBEDate) = 1)

OPEN curDCBE
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Colon Cancer DCBE Encounter',0
FETCH NEXT FROM curDCBE INTO @pat,@date,@src

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

			--SELECT @gen = LastNumber 
			--FROM GENERATOR
			SET @encnum = dbo.GenerateEncounterKey(@pat)

--print 'Patient Id: '@pat
--print '#chars: ' len(@pat)

		--COMMENT--
/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
 AS A STRING FOR THE ENCOUNTER KEY FIELD.*/


--SET @encstring = cast(cast(@pat as integer)as varchar(15)) + cast(rand()+1/rand(day(@date))as varchar(10))
--SET @encstring = cast(cast(@pat as integer) as varchar(15)) + cast(@gen as varchar(15))
--SET @encnum = CAST(@encstring AS numeric(18,3)) 
--print 'Encounterkey: ' + @encnum
--print '#chars: ' + len(@encnum)
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
		FETCH NEXT FROM curDCBE INTO @pat,@date,@src
		
	COMMIT	
	END
END

CLOSE curDCBE
DEALLOCATE curDCBE

SET @sirow = 'PH Colon Cancer DCBE Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Colon Cancer DCBE Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;


EXEC dbo.upActivityLog 'End PH Colon Cancer Encounter',0,@day;
