

CREATE PROCEDURE [dbo].[upODS_CDM_Encounters] AS

Declare @pat bigint
Declare @apt float
Declare @date datetime

Declare @patX bigint
Declare @aptX float
Declare @dateX datetime

Declare @gen bigint
Declare @trow int
Declare @irow int
Declare	@urow int
Declare @drow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @surow varchar(50)
Declare @sdrow varchar(50)
Declare @exists int

Declare @encstring as varchar(25)
Declare @encnum as numeric(13,3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin CDM Encounter',0,@day;

DECLARE	curEnc CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	PAT.PatientId, 
	CESS.AppointmentId,
	CESS.AppointmentDateTime
FROM vwSTG_SMOKING_CESSATION AS CESS 
	INNER JOIN PATIENT AS PAT
	ON CESS.DOB = PAT.DOB 
	AND dbo.FormattedSSN(CESS.SponsorSSN) = PAT.SponsorSSN
	AND REPLACE(CESS.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	CESS.AppointmentId,
	CESS.AppointmentDateTime
FROM vwSTG_SMOKING_CESSATION AS CESS 
	INNER JOIN PATIENT AS PAT
	ON dbo.FormattedSSN(CESS.SponsorSSN) = PAT.SponsorSSN
	AND REPLACE(CESS.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	CESS.AppointmentId,
	CESS.AppointmentDateTime
FROM vwSTG_SMOKING_CESSATION AS CESS 
	INNER JOIN PATIENT AS PAT
	ON CESS.DOB = PAT.DOB 
	AND REPLACE(CESS.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	CESS.AppointmentId,
	CESS.AppointmentDateTime
FROM vwSTG_SMOKING_CESSATION AS CESS 
	INNER JOIN PATIENT AS PAT
	ON CESS.DOB = PAT.DOB 
	AND dbo.FormattedSSN(CESS.SponsorSSN) = PAT.SponsorSSN
UNION

SELECT DISTINCT
	PAT.PatientId, 
	BMI.AppointmentId,
	BMI.AppointmentDateTime
FROM vwSTG_BMI AS BMI 
	INNER JOIN PATIENT AS PAT
	ON BMI.DOB = PAT.DOB 
	AND dbo.FormattedSSN(BMI.SponsorSSN) = PAT.SponsorSSN
	AND REPLACE(BMI.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	BMI.AppointmentId,
	BMI.AppointmentDateTime
FROM vwSTG_BMI AS BMI 
	INNER JOIN PATIENT AS PAT
	ON dbo.FormattedSSN(BMI.SponsorSSN) = PAT.SponsorSSN
	AND REPLACE(BMI.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	BMI.AppointmentId,
	BMI.AppointmentDateTime
FROM vwSTG_BMI AS BMI 
	INNER JOIN PATIENT AS PAT
	ON BMI.DOB = PAT.DOB 
	AND REPLACE(BMI.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	BMI.AppointmentId,
	BMI.AppointmentDateTime
FROM vwSTG_BMI AS BMI 
	INNER JOIN PATIENT AS PAT
	ON BMI.DOB = PAT.DOB 
	AND dbo.FormattedSSN(BMI.SponsorSSN) = PAT.SponsorSSN
UNION	

SELECT DISTINCT
	PAT.PatientId, 
	AP.[Appointment Id],
	AP.[Appointment Date/Time]
FROM vwSTG_ADDITIONAL_PROVIDER AS AP 
	INNER JOIN PATIENT AS PAT
	ON AP.DOB = PAT.DOB 
	AND dbo.FormattedSSN(AP.[Sponsor SSN]) = PAT.SponsorSSN
	AND REPLACE(AP.[Full Name],' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	AP.[Appointment Id],
	AP.[Appointment Date/Time]
FROM vwSTG_ADDITIONAL_PROVIDER AS AP 
	INNER JOIN PATIENT AS PAT
	ON dbo.FormattedSSN(AP.[Sponsor SSN]) = PAT.SponsorSSN
	AND REPLACE(AP.[Full Name],' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	AP.[Appointment Id],
	AP.[Appointment Date/Time]
FROM vwSTG_ADDITIONAL_PROVIDER AS AP 
	INNER JOIN PATIENT AS PAT
	ON AP.DOB = PAT.DOB 
	AND REPLACE(AP.[Full Name],' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId, 
	AP.[Appointment Id],
	AP.[Appointment Date/Time]
FROM vwSTG_ADDITIONAL_PROVIDER AS AP 
	INNER JOIN PATIENT AS PAT
	ON AP.DOB = PAT.DOB 
	AND dbo.FormattedSSN(AP.[Sponsor SSN]) = PAT.SponsorSSN

UNION
SELECT DISTINCT
	PAT.PatientId,
	999999999 AS CDMAppointmentId,
	IMM.ImmunizationDate
FROM [NHJAX-CACHE].STAGING.dbo.IMMUNIZATIONS AS IMM 
	INNER JOIN PATIENT AS PAT
	ON IMM.DOB = PAT.DOB 
	AND dbo.FormattedSSN(IMM.SponsorSSN) = PAT.SponsorSSN
	AND REPLACE(IMM.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId,
	999999999 AS CDMAppointmentId,
	IMM.ImmunizationDate
FROM [NHJAX-CACHE].STAGING.dbo.IMMUNIZATIONS AS IMM 
	INNER JOIN PATIENT AS PAT
	ON dbo.FormattedSSN(IMM.SponsorSSN) = PAT.SponsorSSN
	AND REPLACE(IMM.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId,
	999999999 AS CDMAppointmentId,
	IMM.ImmunizationDate
FROM [NHJAX-CACHE].STAGING.dbo.IMMUNIZATIONS AS IMM 
	INNER JOIN PATIENT AS PAT
	ON IMM.DOB = PAT.DOB 
	AND REPLACE(IMM.FullName,' ','') = REPLACE(PAT.FullName,' ','')
UNION
SELECT DISTINCT
	PAT.PatientId,
	999999999 AS CDMAppointmentId,
	IMM.ImmunizationDate
FROM [NHJAX-CACHE].STAGING.dbo.IMMUNIZATIONS AS IMM 
	INNER JOIN PATIENT AS PAT
	ON IMM.DOB = PAT.DOB 
	AND dbo.FormattedSSN(IMM.SponsorSSN) = PAT.SponsorSSN


OPEN curEnc
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch CDM Encounter',0
FETCH NEXT FROM curEnc INTO @pat,@apt,@date

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@aptX = CDMAppointmentId,
				@dateX = AppointmentDatetime
		FROM NHJAX_ODS.dbo.Patient_Encounter
		WHERE	PatientId = @pat
			AND AppointmentDatetime = @date
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
			UPDATE GENERATOR SET LastNumber=LastNumber+1

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
				CDMAppointmentId)
				VALUES(@pat,@date,11,@encnum,@apt);
				SET @irow = @irow + 1
			END
			ELSE
			BEGIN
			--Append CDMAppointmentId if needed.
				IF @aptX IS NULL
				BEGIN
					UPDATE NHJAX_ODS.dbo.PATIENT_ENCOUNTER
					SET CDMAppointmentId = @apt
					WHERE PatientId = @pat
					AND AppointmentDatetime = @date
					
					SET @urow = @urow + 1
				END
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curEnc INTO @pat,@apt,@date
		
	COMMIT	
	END
END

CLOSE curEnc
DEALLOCATE curEnc


--CHECK FOR RESIDUAL DUPLICATES
Declare @enc bigint
Declare @cdm float
Declare @nam varchar(32)
Declare @ssn varchar(15)
Declare @dt datetime
Declare @dob datetime

Declare @namX varchar(32)
Declare @ssnX varchar(15)
Declare @dtX datetime
Declare @dobX datetime

DECLARE	curDel CURSOR FAST_FORWARD FOR
SELECT
	PE.PatientEncounterId, 
	PE.CDMAppointmentId, 
	PAT.FullName,
	PAT.SponsorSSN,
	PE.AppointmentDateTime,
	PAT.DOB
FROM PATIENT_ENCOUNTER AS PE
INNER JOIN PATIENT AS PAT
ON PAT.PatientId = PE.PatientId
WHERE CDMAppointmentId IN(
SELECT CDMAppointmentId FROM PATIENT_ENCOUNTER
WHERE CDMAppointmentId IS NOT NULL
GROUP BY CDMAppointmentId
HAVING COUNT(CDMAppointmentId) > 1)
AND PE.SourceSystemId = 11
AND PE.PatientAppointmentKey IS NULL
AND PE.CreatedDate > DATEADD(d,-60,getdate())
AND PE.CDMAppointmentId <> 999999999

OPEN curDel

SET @drow = 0

EXEC dbo.upActivityLog 'Fetch CDM Deletions',0
FETCH NEXT FROM curDel INTO @enc,@cdm,@nam,@ssn,@dt,@dob

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
	--LOOP Through existing items to make sure there are no matches.
	DECLARE	curInner CURSOR FAST_FORWARD FOR
	SELECT 
		PAT.FullName,
		PAT.SponsorSSN,
		PE.AppointmentDateTime,
		PAT.DOB
	FROM PATIENT_ENCOUNTER AS PE
	INNER JOIN PATIENT AS PAT
	ON PAT.PatientId = PE.PatientId
	WHERE PE.CDMAppointmentId = @cdm
	AND PE.SourceSystemId <> 11
	
	OPEN curInner
	
	FETCH NEXT FROM curInner INTO @namX,@ssnX,@dtX,@dobX
	if(@@FETCH_STATUS = 0)
		BEGIN
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				IF (@nam <> @namX
				OR @dob <> @dobX
				OR @dt <> @dtX)
				AND @ssn = @ssnX
				BEGIN
				
				DELETE FROM PATIENT_ENCOUNTER
				WHERE PatientEncounterId = @enc
				
				SET @drow = @drow + 1
				END
			
			FETCH NEXT FROM curInner INTO @namX,@ssnX,@dtX,@dobX
			END
		END
		CLOSE curInner
		DEALLOCATE curInner
	--
	
	FETCH NEXT FROM curDel INTO @enc,@cdm,@nam,@ssn,@dt,@dob
		
	COMMIT	
	END
END

CLOSE curDel
DEALLOCATE curDel

SET @sirow = 'CDM Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @surow = 'CDM Encounter Updated: ' + CAST(@urow AS varchar(50))
SET @sdrow = 'CDM Encounter Deleted: ' + CAST(@drow AS varchar(50))
SET @strow = 'CDM Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End CDM Encounter',0,@day;

PRINT @sirow
PRINT @surow
PRINT @sdrow
PRINT @strow