



CREATE PROCEDURE [dbo].[upODS_AHLTACervical_Patient_Encounters] AS

Declare @pat bigint
Declare @date datetime
Declare @stat bigint
Declare @apt numeric(14,3)
Declare @typ bigint

Declare @patX bigint
Declare @dateX datetime
Declare @statX bigint
Declare @aptX numeric(14,3)
Declare @typX bigint

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

EXEC dbo.upActivityLog 'Begin AHLTA Cervical Encounter',0,@day;


DECLARE	curEnc CURSOR FAST_FORWARD FOR 
SELECT     
	PAT.PatientId, 
	ACC.[Appointment Date/Time], 
	CASE ACC.[Appointment Status]
		WHEN 'KEPT' THEN 2
		WHEN 'AdminClose' THEN 9
		WHEN 'CANCEL' THEN 3
		ELSE 0
	END AS AppointmentStatusID, 
	ACC.[Appointment Id], 
    CASE ACC.[Appointment Type]
		WHEN 'INITIAL SPECIALTY CARE APPT' THEN 1288
		WHEN 'GROUP APPT WITH MULTIPLE PTS' THEN 643
		WHEN 'PROCEDURE APPT' THEN 1137
		WHEN 'ACUTE APPT' THEN 224
		WHEN 'INITIAL PRIMARY CARE APPT' THEN 1049
		WHEN 'ESTABLISHED/FOLLOW UP APPT' THEN 551
		WHEN 'TELEPHONE CONSULT' THEN 1309
		WHEN 'OPEN ACCESS APPT' THEN 1008
		WHEN 'WELLNESS/HEALTH PROMOTION APPT' THEN 1458
		WHEN 'AMBULATORY PROCEDURE VISIT' THEN 261
		WHEN 'ROUTINE APPT' THEN 1232
		ELSE 0
	END AS AppointmentTypeId
FROM vwSTG_AHLTA_CERVICAL_CPT AS ACC 
	INNER JOIN vwODS_PATIENT_FMP AS PAT 
	ON ACC.FMP = PAT.FamilyMemberPrefixKey 
	AND ACC.SponsorSSN = PAT.SponsorSSN

OPEN curEnc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch AHLTA Cervical Encounter',0
FETCH NEXT FROM curEnc INTO @pat,@date,@stat,@apt,@typ

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@dateX = AppointmentDatetime,
				@statX = AppointmentStatusId,
				@aptX = PatientAppointmentKey,
				@typX = AppointmentTypeId
		FROM NHJAX_ODS.dbo.Patient_Encounter
		WHERE	PatientId = @pat
			AND SourceSystemId = 11
			AND AppointmentDatetime = @date
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
			--must update generator before calling function.
			UPDATE GENERATOR SET LastNumber=LastNumber+1
			WHERE GeneratorTypeId = 1
			
			SET @encnum = dbo.GenerateEncounterKey(@pat)
			--SELECT @gen = LastNumber 
			--FROM GENERATOR


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
				AppointmentStatusId,
				PatientAppointmentKey,
				AppointmentTypeId)
				VALUES(@pat,@date,11,@encnum,@stat,@apt,@typ);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curEnc INTO @pat,@date,@stat,@apt,@typ
		
	COMMIT	
	END
END

CLOSE curEnc
DEALLOCATE curEnc

SET @sirow = 'AHLTA Cervical Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'AHLTA Cervical Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End AHLTA Cervical Encounter',0;

--REPEAT FOR DIAGNOSIS CODES

EXEC dbo.upActivityLog 'Begin AHLTA Cervical Encounter ICD',0;


DECLARE	curEnc CURSOR FAST_FORWARD FOR 
SELECT     
	PAT.PatientId, 
	ACC.[Appointment Date/Time], 
	CASE ACC.[Appointment Status]
		WHEN 'KEPT' THEN 2
		WHEN 'AdminClose' THEN 9
		WHEN 'CANCEL' THEN 3
		ELSE 0
	END AS AppointmentStatusID, 
	ACC.[Appointment Id], 
    CASE ACC.[Appointment Type]
		WHEN 'INITIAL SPECIALTY CARE APPT' THEN 1288
		WHEN 'GROUP APPT WITH MULTIPLE PTS' THEN 643
		WHEN 'PROCEDURE APPT' THEN 1137
		WHEN 'ACUTE APPT' THEN 224
		WHEN 'INITIAL PRIMARY CARE APPT' THEN 1049
		WHEN 'ESTABLISHED/FOLLOW UP APPT' THEN 551
		WHEN 'TELEPHONE CONSULT' THEN 1309
		WHEN 'OPEN ACCESS APPT' THEN 1008
		WHEN 'WELLNESS/HEALTH PROMOTION APPT' THEN 1458
		WHEN 'AMBULATORY PROCEDURE VISIT' THEN 261
		WHEN 'ROUTINE APPT' THEN 1232
		ELSE 0
	END AS AppointmentTypeId
FROM vwSTG_AHLTA_CERVICAL_ICD9 AS ACC 
	INNER JOIN vwODS_PATIENT_FMP AS PAT 
	ON ACC.FMP = PAT.FamilyMemberPrefixKey 
	AND ACC.SponsorSSN = PAT.SponsorSSN

OPEN curEnc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch AHLTA Cervical Encounter ICD',0
FETCH NEXT FROM curEnc INTO @pat,@date,@stat,@apt,@typ

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@dateX = AppointmentDatetime,
				@statX = AppointmentStatusId,
				@aptX = PatientAppointmentKey,
				@typX = AppointmentTypeId
		FROM NHJAX_ODS.dbo.Patient_Encounter
		WHERE	PatientId = @pat
			AND SourceSystemId = 11
			AND AppointmentDatetime = @date
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
			--must update generator before calling function.
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
				EncounterKey,
				AppointmentStatusId,
				PatientAppointmentKey,
				AppointmentTypeId)
				VALUES(@pat,@date,11,@encnum,@stat,@apt,@typ);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curEnc INTO @pat,@date,@stat,@apt,@typ
		
	COMMIT	
	END
END

CLOSE curEnc
DEALLOCATE curEnc

SET @sirow = 'AHLTA Cervical Encounter ICD Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'AHLTA Cervical Encounter ICD Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End AHLTA Cervical Encounter ICD',0,@day;