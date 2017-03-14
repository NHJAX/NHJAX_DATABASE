

CREATE PROCEDURE [dbo].[upODS_PatientEncounter] AS

Declare @err varchar(4000)
Declare @ern int

--Update Indexes: PATIENT_APPOINTMENT
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(2000)

BEGIN TRY

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_PATIENT_APPOINTMENT

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'PATIENT_APPOINTMENT'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.PATIENT_APPOINTMENT

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: PATIENT_APPOINTMENT was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25 OR @DIFF = 0
	BEGIN
	SET @Msg = 'MDE: PATIENT_APPOINTMENT had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF LEN(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'PATIENT_APPOINTMENT'

END TRY
BEGIN CATCH
	SELECT @err = 'ERROR: CHK ENC:Housekeeping ' + ERROR_MESSAGE();
	SELECT @ern = ERROR_NUMBER();
		
	EXEC dbo.upActivityLog @err , @ern
	EXEC upSendMail @Sub='SQL Server Error 1', @Msg = @err 
END CATCH

--Update Indexes: KG_ADC_DATA
BEGIN TRY
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_KG_ADC_DATA

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'KG_ADC_DATA'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.KG_ADC_DATA

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: KG_ADC_DATA was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25 OR @DIFF = 0
	BEGIN
	SET @Msg = 'MDE: KG_ADC_DATA had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF LEN(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'KG_ADC_DATA'
END TRY
BEGIN CATCH
	SELECT @err = 'ERROR: CHK ENC:KgAdcData ' + ERROR_MESSAGE();
	SELECT @ern = ERROR_NUMBER();
		
	EXEC dbo.upActivityLog @err , @ern
	EXEC upSendMail @Sub='SQL Server Error 2', @Msg = @err  
END CATCH

BEGIN TRY
--Update Indexes: ENCOUNTER
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ENCOUNTER

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ENCOUNTER'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ENCOUNTER

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ENCOUNTER was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25 OR @DIFF = 0
	BEGIN
	SET @Msg = 'MDE: ENCOUNTER had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF DataLength(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'ENCOUNTER'

END TRY
BEGIN CATCH
	SELECT @err = 'ERROR: CHK ENC:Encounter ' + ERROR_MESSAGE();
	SELECT @ern = ERROR_NUMBER();
		
	EXEC dbo.upActivityLog @err , @ern
	EXEC upSendMail @Sub='SQL Server Error 3', @Msg = @err 
	--EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK ENC:Encounter'
END CATCH

Declare @encID bigint
Declare @appt decimal
Declare @pat bigint
Declare @date datetime
Declare @loc bigint
Declare @pro bigint
Declare @duration decimal
Declare @stat bigint
Declare @reason varchar(80)
Declare @disp bigint
Declare @enc decimal
Declare @type bigint
Declare @ref bigint
Declare @dis datetime
Declare @adm datetime
Declare @made datetime
Declare @atc bigint
Declare	@datc datetime
Declare @pri bigint
Declare @ss bigint
Declare @ac bigint
Declare @rel bigint
Declare @drel datetime
Declare @mep bigint
Declare @non bit
Declare @dmis bigint
Declare @er varchar(30)
Declare @tp int
Declare @wi int
Declare @comm varchar(35)
Declare @dcan datetime
Declare @can bigint
Declare @reas int
Declare @idX bigint
Declare @apptX decimal
Declare @patX decimal
Declare @dateX datetime
Declare @locX bigint
Declare @proX bigint
Declare @durationX decimal
Declare @statX bigint
Declare @reasonX varchar(80)
Declare @dispX bigint
Declare @encX decimal
Declare @typeX bigint
Declare @refX bigint
Declare @disX datetime
Declare @admX datetime
Declare @madeX datetime
Declare @atcX bigint
Declare	@datcX datetime
Declare @priX bigint
Declare @ssX bigint
Declare @acX bigint
Declare @relX bigint
Declare @drelX datetime
Declare @mepX bigint
Declare @nonX bit
Declare @dmisX bigint
Declare @erX varchar(30)
Declare @tpX int
Declare @wiX int
Declare @commX varchar(35)
Declare @dcanX datetime
Declare @canX bigint
Declare @reasX int

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @toDate datetime

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Patient Encounters',0,@day;
SET @tempDate = DATEADD(d,-400,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 
SET @toDate = DATEADD(DAY,365,getdate())

--UPDATE EncounterKey
DECLARE @dt datetime
DECLARE @key numeric(13,3)

DECLARE cur2 CURSOR FAST_FORWARD FOR
SELECT     
	PatientId, 
	AppointmentDateTime,
	EncounterKey
FROM PATIENT_ENCOUNTER 
WHERE AppointmentStatusId NOT IN (3,5,50,200,100,201,202,203,300,400)
	AND EncounterKey < 1
	AND AppointmentDateTime > @tempdate
	--AND PatientId = 70
	 
OPEN cur2

FETCH NEXT FROM cur2 INTO @pat,@dt,@key

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	SET @encX = 0
	BEGIN TRANSACTION
		--BEGIN TRY
		SELECT 
		@encX = EncounterKey
		FROM PATIENT_ENCOUNTER
		WHERE PatientId = @pat
		AND AppointmentDateTime = @dt
		AND AppointmentStatusId = 50
			
			
		
		IF @encX > 0	
			BEGIN
			--PRINT @pat
			--PRINT @dt
			--PRINT @key
			--PRINT @encX
			
			UPDATE PATIENT_ENCOUNTER
			SET 
			EncounterKey = @encX
			WHERE PatientId = @pat
			AND AppointmentDateTime = @dt
			AND AppointmentStatusId NOT IN (3,5,50,200,100,201,202,203,300,305,400)
			END
			
	FETCH NEXT FROM cur2 INTO @pat,@dt,@key
		--END TRY
		--BEGIN CATCH
		--SELECT @err = 'ERROR: ETL ENC:EncounterKey ' + ERROR_MESSAGE();
		--SELECT @ern = ERROR_NUMBER();
				
		--EXEC dbo.upActivityLog @err , @ern
		--EXEC upSendMail @Sub='SQL Server Error 4', @Msg = @err 
		----EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL ENC:EncounterKey'
		--END CATCH
	COMMIT	
	END

END
CLOSE cur2
DEALLOCATE cur2



DECLARE curAppt CURSOR FAST_FORWARD FOR
SELECT DISTINCT
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.KEY_PATIENT_APPOINTMENT, 
	PAT.PatientId, 
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.APPOINTMENT_DATE_TIME, 
	LOC.HospitalLocationId,	
	ISNULL(PRO.ProviderId, 0) AS ProviderId, 
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.DURATION, 
	ISNULL(STAT.AppointmentStatusId, 0) AS StatusId, 
	ISNULL(NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.REASON_FOR_APPOINTMENT, 
	NHJAX_ODS.dbo.vwMDE_ENCOUNTER.CHIEF_COMPLAINT) AS Reason_for_Appointment, 
	ISNULL(DISP.PatientDispositionId, 0) AS PatientDispositionId, 
	ISNULL(NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.ENCOUNTER_PTR_IEN, 0) AS Encounter_IEN, 
	ISNULL(TYPE.AppointmentTypeId, 0) AS AppointmentTypeId, 
	REF.ReferralId, 
	CONVERT(DATETIME, NHJAX_ODS.dbo.vwMDE_ENCOUNTER.DISCHARGE_DATE) AS DischargeDate, 
	dbo.AdmissionDateTime(NHJAX_ODS.dbo.vwMDE_ENCOUNTER.ADMISSION_DATE__FORMAT_) AS AdmissionDate, 
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.DATE_APPOINTMENT_MADE AS DateAppointmentMade, 
	ATC.AccessToCareId, 
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.ATC_REQUEST_DATE_TIME AS AccessToCareDate, 
	ISNULL(PRI.PriorityId, 0) AS PriorityId, 
	ISNULL(SS.SourceSystemId, 1) AS SourceSystemId, 
	CASE NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.ARRIVAL_CATEGORY 
		WHEN 'NON-URGENT' THEN 1 
		WHEN 'URGENT' THEN 2 
		WHEN 'EMERGENCY' THEN 3 
		ELSE 0 END AS ArrivalCategoryId,
	CASE NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.RELEASE_CONDITION 
		WHEN 'IMPROVED' THEN 1 
		WHEN 'UNCHANGED' THEN 2 
		ELSE 0 END AS ReleaseConditionId, 
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.DATE_TIME_OF_RELEASE, 
	MEPRS.MeprsCodeId,
	CASE NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.WORKLOAD_TYPE
		WHEN 'NON-COUNT' THEN 1
		ELSE 0 END AS IsNonCount,
	DMIS.DMISId,
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.ER_ENTRY_NUMBER,
	ISNULL(TP.ThirdPartyPayerId, 0),
	ISNULL(WI.WalkInId, 0),
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.APPOINTMENT_COMMENT,
	NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.CANCELLATION_DATE_TIME,
	CHCS_USER.CHCSUserId,
	CASE ISNULL(NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.PATIENT_CANCELLED_REASON,'0')
		WHEN '0' THEN 0
		WHEN 'CANCEL COMPLETELY' THEN 1
		WHEN 'RESCHEDULE' THEN 2
		ELSE 3
	END AS PatientCancelledReason
FROM	MEPRS_CODE AS MEPRS 
	INNER JOIN HOSPITAL_LOCATION AS LOC 
	ON MEPRS.MeprsCodeId = LOC.MeprsCodeId 
	RIGHT OUTER JOIN ACCESS_TO_CARE AS ATC 
	RIGHT OUTER JOIN NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT 
	INNER JOIN PATIENT AS PAT 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.NAME_IEN = PAT.PatientKey 
	INNER JOIN PROVIDER AS PRO 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.PROVIDER_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN NHJAX_ODS.dbo.vwMDE_KG_ADC_DATA 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.KEY_PATIENT_APPOINTMENT = NHJAX_ODS.dbo.vwMDE_KG_ADC_DATA.APPOINTMENT_IEN 
	LEFT OUTER JOIN SOURCE_SYSTEM AS SS 
	ON NHJAX_ODS.dbo.vwMDE_KG_ADC_DATA.SOURCE_SYSTEM = SS.SourceSystemDesc 
	LEFT OUTER JOIN PRIORITY AS PRI 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.PRIORITY = PRI.PriorityDesc 
	LEFT OUTER JOIN NHJAX_ODS.dbo.vwMDE_ENCOUNTER
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.ENCOUNTER_PTR_IEN = NHJAX_ODS.dbo.vwMDE_ENCOUNTER.KEY_ENCOUNTER 
	ON  ATC.AccessToCareKey = NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.ATC_CATEGORY_IEN 
	LEFT OUTER JOIN APPOINTMENT_TYPE AS TYPE 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.APPOINTMENT_TYPE_IEN = TYPE.AppointmentTypeKey 
	LEFT OUTER JOIN NHJAX_ODS.dbo.vwPatientEncounterReferrals 
	INNER JOIN REFERRAL AS REF 
	ON NHJAX_ODS.dbo.vwPatientEncounterReferrals.ReferralKey = REF.ReferralKey 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.KEY_PATIENT_APPOINTMENT = NHJAX_ODS.dbo.vwPatientEncounterReferrals.PatientEncounterKey 
	LEFT OUTER JOIN PATIENT_DISPOSITION AS DISP 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.OUTPATIENT_DISPOSITION_IEN = DISP.PatientDispositionKey 
	LEFT OUTER JOIN APPOINTMENT_STATUS AS STAT 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.APPOINTMENT_STATUS_IEN = STAT.AppointmentStatusKey 
	ON LOC.HospitalLocationKey = NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.CLINIC_IEN
	LEFT OUTER JOIN NHJAX_ODS.dbo.vwODS_MEDICAL_CENTER_DIVISION
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.APPT_DIVISION_IEN = NHJAX_ODS.dbo.vwODS_MEDICAL_CENTER_DIVISION.KEY_MEDICAL_CENTER_DIVISION
	INNER JOIN DMIS 
	ON ISNULL(NHJAX_ODS.dbo.vwODS_MEDICAL_CENTER_DIVISION.DMIS_ID_CODE_IEN,1018) = DMIS.DMISKey
	LEFT OUTER JOIN THIRD_PARTY_PAYER AS TP 
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.THIRD_PARTY_PAYER = TP.ThirdPartyPayerDesc
	LEFT OUTER JOIN WALK_IN AS WI
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.WALK_IN = WI.WalkInDesc
	LEFT OUTER JOIN CHCS_USER
	ON NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.CANCELLED_BY_IEN = CHCS_USER.CHCSUserKey
WHERE (NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.APPOINTMENT_DATE_TIME 
	BETWEEN @fromDate AND @toDate)
--WHERE     (PA.APPOINTMENT_DATE_TIME >= @fromDate) 
	--AND (NHJAX_ODS.dbo.vwMDE_PATIENT_APPOINTMENT.NAME_IEN = 3293822)


OPEN curAppt
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch Patient Encounters',0
FETCH NEXT FROM curAppt INTO @appt,@pat,@date,@loc,@pro,@duration,@stat,@reason,@disp,@enc,@type,
	@ref,@dis,@adm,@made,@atc,@datc,@pri,@ss,@ac,@rel,@drel,@mep,@non,@dmis,
	@er,@tp,@wi,@comm,@dcan,@can,@reas
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
		
		Select 	@idX = PatientEncounterId,
			@apptX = PatientAppointmentKey,
			@patX = PatientId,
			@dateX = AppointmentDateTime,
			@locX = HospitalLocationId,
			@proX = ProviderId,
			@durationX = Duration,
			@statX = AppointmentStatusId,
			@reasonX = ReasonForAppointment,
			@dispX = PatientDispositionId,
			@encX = EncounterKey,
			@typeX = AppointmentTypeId,
			@refX = ReferralId,
			@disX = DischargeDateTime,
			@admX = AdmissionDateTime,
			@madeX = DateAppointmentMade,
			@atcX = AccessToCareId,
			@datcX = AccessToCareDate,
			@priX = PriorityId,
			@ssX = SourceSystemId,
			@acX = ArrivalCategoryId,
			@relX = ReleaseConditionId,
			@drelX = ReleaseDateTime,
			@mepX = MeprsCodeId,
			@nonX = IsNonCount,
			@dmisX = DMISId,
			@erX = EREntryNumber,
			@tpX = ThirdPartyPayerId,
			@wiX = WalkInId,
			@commX = AppointmentComment,
			@dcanX = CancellationDateTime,
			@canX = CancelledBy,
			@reasX = PatientCancelledReasonId
		FROM PATIENT_ENCOUNTER
		WHERE PatientAppointmentKey = @appt
		AND SourceSystemId NOT IN (7)
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN

				PRINT @appt
				PRINT @pat
				PRINT @enc

				INSERT INTO PATIENT_ENCOUNTER(
				PatientAppointmentKey,
				PatientId,
				AppointmentDateTime,
				HospitalLocationId,
				ProviderId,
				Duration,
				AppointmentStatusId,
				ReasonForAppointment,
				PatientDispositionId,
				EncounterKey,
				AppointmentTypeId,
				ReferralId,
				DischargeDateTime,
				AdmissionDateTime,
				DateAppointmentMade,
				AccessToCareId,
				AccessToCareDate,
				PriorityId,
				SourceSystemId,
				ArrivalCategoryId,
				ReleaseConditionId,
				ReleaseDateTime,
				MeprsCodeId,
				IsNonCount,
				DMISId,
				EREntryNumber,
				ThirdPartyPayerId,
				WalkInId,
				PatientCancelledReasonId,
				CancelledBy,
				CancellationDateTime,
				AppointmentComment)
				VALUES(@appt,@pat,@date,@loc,@pro,@duration,
				@stat,@reason,@disp,@enc,@type,@ref,@dis,@adm,
				@made,@atc,@datc,@pri,@ss,@ac,@rel,@drel,@mep,@non,@dmis,@er,
				@tp,@wi,@reas,@can,@dcan,@comm);
				SELECT @idX = SCOPE_IDENTITY();
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

		IF	@pat <> @patX
		OR	@date <> @dateX
		OR	@loc <> @locX
		OR	@pro <> @proX
		OR	@duration <> @durationX
		OR	@stat <> @statX
		OR	@reason <> @reasonX
		OR	@disp <> @dispX
		OR	@enc <> @encX
		OR	@type <> @typeX	
		OR	@ref <> @refX
		OR	@dis <> @disX
		OR	@adm <> @admX
		OR	@made <> @madeX
		OR	@atc <> @atcX
		OR	@datc <> @datcX
		OR	@pri <> @priX
		OR  (@ss <> @ssX AND @ss > 1)
		OR	@ac <> @acX
		OR	@rel <> @relX
		OR	@drel <> @drelX
		OR	@mep <> @mepX
		OR	@non <> @nonX
		OR	@dmis <> @dmisX
		OR 	(@pat Is Not Null AND @patX Is Null)
		OR 	(@date Is Not Null AND @dateX Is Null)
		OR 	(@loc Is Not Null AND @locX Is Null)
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@duration Is Not Null AND @durationX Is Null)
		OR 	(@stat Is Not Null AND @statX Is Null)
		OR 	(@reason Is Not Null AND @reasonX Is Null)
		OR 	(@disp Is Not Null AND @dispX Is Null)
		OR	(@enc Is Not Null AND @encX Is Null)
		OR	(@type Is Not Null AND @typeX Is Null)
		OR	(@ref Is Not Null AND @refX Is Null)
		OR	(@dis Is Not Null AND @disX Is Null)
		OR	(@adm Is Not Null AND @admX Is Null)
		OR	(@made Is Not Null AND @madeX Is Null)
		OR	(@atc Is Not Null AND @atcX Is Null)
		OR	(@datc Is Not Null AND @datcX Is Null)
		OR	(@pri Is Not Null AND @priX Is Null)
		OR	(@ss Is Not Null AND @ssX Is Null)
		OR	(@ac Is Not Null AND @acX Is Null)
		OR	(@rel Is Not Null AND @relX Is Null)
		OR	(@drel Is Not Null AND @drelX Is Null)
		OR	(@mep Is Not Null AND @mepX Is Null)
		OR	(@non Is Not Null AND @nonX Is Null)
		OR	(@dmis Is Not Null AND @dmisX Is Null)
			BEGIN
			
			UPDATE PATIENT_ENCOUNTER
			SET 	PatientId = @pat,
				AppointmentDateTime = @date,
				HospitalLocationId = @loc,
				ProviderId = @pro,
				Duration = @duration,
				AppointmentStatusId = @stat,
				ReasonForAppointment = @reason,
				PatientDispositionId = @disp,
				EncounterKey = @enc,
				AppointmentTypeId = @type,
				ReferralId = @ref,
				DischargeDateTime = @dis,
				AdmissionDateTime = @adm,
				DateAppointmentMade = @made,
				AccessToCareId = @atc,
				AccessToCareDate = @datc,
				PriorityId = @pri,
				SourceSystemId = @ss,
				ArrivalCategoryId = @ac,
				ReleaseConditionId = @rel,
				ReleaseDateTime = @drel,
				MeprsCodeId = @mep,
				IsNonCount = @non,
				DMISId = @dmis,
				UpdatedDate = GETDATE()
			WHERE PatientAppointmentKey = @appt
			AND SourceSystemId NOT IN (7);
			SET @urow = @urow + 1
			END
			--20120517 Added ER Entry Number
			IF	@er <> @erX
			OR	(@er Is Not Null AND @erX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET EREntryNumber = @er,
					UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
			IF @tp <> @tpX
			OR (@tp Is Not Null AND @tpX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET ThirdPartyPayerId = @tp,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
			IF @wi <> @wiX
			OR (@wi Is Not Null AND @wiX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET WalkInId = @wi,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
			IF @comm <> @commX
			OR (@comm Is Not Null AND @commX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET AppointmentComment = @comm,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
			IF @dcan <> @dcanX
			OR (@dcan Is Not Null AND @dcanX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET CancellationDateTime = @dcan,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
			IF @can <> @canX
			OR (@can Is Not Null AND @canX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET CancelledBy = @can,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
			IF @reas <> @reasX
			OR (@reas Is Not Null AND @reasX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET PatientCancelledReasonId = @reas,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @appt
				AND SourceSystemId NOT IN (7);
			END
			
		END
		SET @trow = @trow + 1

		-- Check for duplicate encounters
		
		IF @enc <> 0
			
			BEGIN
				
				SELECT @encID = PatientEncounterId
				FROM PATIENT_ENCOUNTER 
				WHERE EncounterKey = @enc
				AND PatientEncounterId <> @idX

				SET @exists = @@RowCount
				If @exists <> 0 
					BEGIN
						
						--Update any children
						UPDATE APPOINTMENT_AUDIT_TRAIL
						SET PatientEncounterId = @idX
						WHERE PatientEncounterId = @encID

						UPDATE PATIENT_ENCOUNTER_DETAIL_CODE
						SET PatientEncounterId = @idX
						WHERE PatientEncounterId = @encID

						UPDATE ENCOUNTER_DIAGNOSIS
						SET PatientEncounterId = @idX
						WHERE PatientEncounterId = @encID

						UPDATE PATIENT_PROCEDURE
						SET PatientEncounterId = @idX
						WHERE PatientEncounterId = @encID
						--PRINT 'appt'
						--PRINT @appt
						--PRINT 'idx'
						--PRINT @idx
						--PRINT 'enc'
						--PRINT @enc
						--PRINT 'encid'
						--PRINT @encID

						--Delete the duplicate encouter/free text
						DELETE FROM ENCOUNTER_DIAGNOSIS_FREE_TEXT
						WHERE PatientEncounterId = @encId

						DELETE FROM ENCOUNTER_DIAGNOSIS
						WHERE PatientEncounterId = @encId

						DELETE FROM PATIENT_ENCOUNTER
						WHERE PatientEncounterId = @encID
						SET @drow = @drow + 1
					END
			
			END

		FETCH NEXT FROM curAppt INTO @appt,@pat,@date,@loc,@pro,@duration,@stat,@reason,@disp,
			@enc,@type,@ref,@dis,@adm,@made,@atc,@datc,@pri,@ss,@ac,@rel,
			@drel,@mep,@non,@dmis,@er,@tp,@wi,@comm,@dcan,@can,@reas
			
		--END TRY
		--BEGIN CATCH
		--	SELECT @err = 'ERROR: ETL ENC:PatientEncounter ' + ERROR_MESSAGE();
		--	SELECT @ern = ERROR_NUMBER();
				
		--	EXEC dbo.upActivityLog @err , @ern
		--	EXEC upSendMail @Sub='SQL Server Error 5', @Msg = @err 
		--	--EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL ENC:PatientEncounter'
		--END CATCH
			
	COMMIT
	END

END
CLOSE curAppt
DEALLOCATE curAppt

SET @surow = 'Patient Encounters Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient Encounters Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'Patient Encounters Deleted: ' + CAST(@drow AS varchar(50))
SET @strow = 'Patient Encounters Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient Encounters',0,@day;

--Add additional loop to look for encounters with no associated appointment.
EXEC dbo.upActivityLog 'Begin Patient Encounters2',0,@day;


DECLARE curEnc CURSOR FAST_FORWARD FOR
SELECT  0 AS Key_Patient_Appointment, 
	PAT.PatientId, 
	ENC.DATE_TIME, 
	CASE TYPE_ 
		WHEN 'EMERGENCY ROOM' THEN 174
		ELSE ISNULL(LOC.HospitalLocationId,0)
		END 
	AS HospitalLocationId, 
	ISNULL(PRO.ProviderId,0) AS ProviderId, 
	0 AS Duration, 
	50 AS AppointmentStatusId, 
    ENC.CHIEF_COMPLAINT, 
	0 AS PatientDispositionId, 
	ENC.KEY_ENCOUNTER, 
	ISNULL(APPT.AppointmentTypeId, 0) AS AppointmentTypeId, 
	NULL AS ReferralId,
	CONVERT(DATETIME,ENC.DISCHARGE_DATE) AS DischargeDate,
	dbo.AdmissionDateTime(ENC.ADMISSION_DATE__FORMAT_) AS AdmissionDate,
	NULL AS DateAppointmentMade,
	NULL AS AccessToCareId,
	NULL AS AccessToCareDate,
	0 AS PriorityId,
	1 AS SourceSystemId,
	0 AS ArrivalCategoryId,
	0 AS ReleaseConditionId,
	CASE TYPE_ 
		WHEN 'EMERGENCY ROOM' THEN 78
		ELSE ISNULL(LOC.MeprsCodeId,0)
		END 
	AS MeprsCodeId,
	CASE TYPE_ 
		WHEN 'EMERGENCY ROOM' THEN 1527
		ELSE ISNULL(MEP.DmisId,2011)
		END 
	AS DMISId
FROM   vwMDE_ENCOUNTER ENC 
	INNER JOIN PATIENT PAT 
	ON ENC.PATIENT_IEN = PAT.PatientKey 
	LEFT OUTER JOIN PROVIDER PRO 
	ON ENC.PROVIDER_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN APPOINTMENT_TYPE APPT 
	ON ENC.TYPE_ = APPT.AppointmentTypeDesc
	LEFT OUTER JOIN HOSPITAL_LOCATION AS LOC
	ON ENC.HOSPITAL_LOCATION_IEN = LOC.HospitalLocationKey
	INNER JOIN MEPRS_CODE AS MEP
	ON LOC.MeprsCodeId = MEP.MeprsCodeId
WHERE ENC.DATE_TIME BETWEEN @fromDate AND DATEADD(DAY,365,Getdate())
--WHERE ENC.DATE_TIME >= @fromDate 

OPEN curEnc
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Patient Encounters2',0
FETCH NEXT FROM curEnc INTO @appt,@pat,@date,@loc,@pro,@duration,@stat,@reason,@disp,@enc,@type,
	@ref,@dis,@adm,@made,@atc,@datc,@pri,@ss,@ac,@rel,@mep,@dmis
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
		--BEGIN TRY
		
		Select 	@idX = PatientEncounterId,
			@apptX = PatientAppointmentKey,
			@patX = PatientId,
			@dateX = AppointmentDateTime,
			@locX = HospitalLocationId,
			@proX = ProviderId,
			@durationX = Duration,
			@statX = AppointmentStatusId,
			@reasonX = ReasonForAppointment,
			@dispX = PatientDispositionId,
			@encX = EncounterKey,
			@typeX = AppointmentTypeId,
			@refX = ReferralId,
			@disX = DischargeDateTime,
			@admX = AdmissionDateTime,
			@madeX = DateAppointmentMade,
			@atcX = AccessToCareId,
			@datcX = AccessToCareDate,
			@priX = PriorityId,
			@ssX = SourceSystemId,
			@acX = ArrivalCategoryId,
			@relX = ReleaseConditionId,
			@mepX = MeprsCodeId,
			@dmisX = DmisId
		FROM PATIENT_ENCOUNTER
		WHERE EncounterKey = @enc 
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN	
				PRINT 'enc2: '
				PRINT @enc
		
				INSERT INTO PATIENT_ENCOUNTER(
				PatientAppointmentKey,
				PatientId,
				AppointmentDateTime,
				HospitalLocationId,
				ProviderId,
				Duration,
				AppointmentStatusId,
				ReasonForAppointment,
				PatientDispositionId,
				EncounterKey,
				AppointmentTypeId,
				ReferralId,
				DischargeDateTime,
				AdmissionDateTime,
				DateAppointmentMade,
				AccessToCareId,
				AccessToCareDate,
				PriorityId,
				SourceSystemId,
				ArrivalCategoryId,
				ReleaseConditionId,
				MeprsCodeId,
				DMISId)
				VALUES(@appt,@pat,@date,@loc,@pro,@duration,
				@stat,@reason,@disp,@enc,@type,@ref,@dis,@adm,
				@made,@atc,@datc,@pri,@ss,@ac,@rel,@mep,@dmis);
	
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN
			--Ignore if match has appt key
			IF @apptX = 0
				BEGIN
				IF	@pat <> @patX
				OR	@date <> @dateX
				OR	@loc <> @locX
				OR	@pro <> @proX
				OR	@duration <> @durationX
				OR	@stat <> @statX
				OR	@reason <> @reasonX
				OR	@disp <> @dispX
				OR	@enc <> @encX
				OR	@type <> @typeX	
				OR	@ref <> @refX
				OR	@dis <> @disX
				OR	@adm <> @admX
				OR	@made <> @madeX
				OR	@atc <> @atcX
				OR	@datc <> @datcX
				OR	@pri <> @priX
				OR  (@ss <> @ssX AND @ss > 1)
				OR	@ac <> @acX
				OR	@rel <> @relX
				OR	@mep <> @mepX
				OR	@dmis <> @dmisX
				OR 	(@pat Is Not Null AND @patX Is Null)
				OR 	(@date Is Not Null AND @dateX Is Null)
				OR 	(@loc Is Not Null AND @locX Is Null)
				OR 	(@pro Is Not Null AND @proX Is Null)
				OR 	(@duration Is Not Null AND @durationX Is Null)
				OR 	(@stat Is Not Null AND @statX Is Null)
				OR 	(@reason Is Not Null AND @reasonX Is Null)
				OR 	(@disp Is Not Null AND @dispX Is Null)
				OR	(@enc Is Not Null AND @encX Is Null)
				OR	(@type Is Not Null AND @typeX Is Null)
				OR	(@ref Is Not Null AND @refX Is Null)
				OR	(@dis Is Not Null AND @disX Is Null)
				OR	(@adm Is Not Null AND @admX Is Null)
				OR	(@made Is Not Null AND @madeX Is Null)
				OR	(@atc Is Not Null AND @atcX Is Null)
				OR	(@datc Is Not Null AND @datcX Is Null)
				OR	(@pri Is Not Null AND @priX Is Null)
				OR	(@ss Is Not Null AND @ssX Is Null)
				OR	(@ac Is Not Null AND @acX Is Null)
				OR	(@rel Is Not Null AND @relX Is Null)
				OR	(@mep Is Not Null AND @mepX Is Null)
				OR	(@dmis Is Not Null AND @dmisX Is Null)
					BEGIN
					
					UPDATE PATIENT_ENCOUNTER
					SET 	PatientId = @pat,
						AppointmentDateTime = @date,
						HospitalLocationId = @loc,
						ProviderId = @pro,
						Duration = @duration,
						AppointmentStatusId = @stat,
						ReasonForAppointment = @reason,
						PatientDispositionId = @disp,
						EncounterKey = @enc,
						AppointmentTypeId = @type,
						ReferralId = @ref,
						DischargeDateTime = @dis,
						AdmissionDateTime = @adm,
						DateAppointmentMade = @made,
						AccessToCareId = @atc,
						AccessToCareDate = @datc,
						PriorityId = @pri,
						SourceSystemId = @ss,
						ArrivalCategoryId = @ac,
						ReleaseConditionId = @rel,
						MeprsCodeId = @mep,
						DMISId = @dmis,
						UpdatedDate = GETDATE()
					WHERE PatientAppointmentKey = @appt
					AND EncounterKey = @enc;
					SET @urow = @urow + 1
					END
				END
				SET @trow = @trow + 1
			END
		FETCH NEXT FROM curEnc INTO @appt,@pat,@date,@loc,@pro,@duration,@stat,@reason,@disp,
			@enc,@type,@ref,@dis,@adm,@made,@atc,@datc,@pri,@ss,@ac,@rel,@mep,@dmis
	
		--END TRY
		--BEGIN CATCH
		--	SELECT @err = 'ERROR: ETL ENC:PatientEncounter2 ' + ERROR_MESSAGE();
		--	SELECT @ern = ERROR_NUMBER();
				
		--	EXEC dbo.upActivityLog @err , @ern
		--	EXEC upSendMail @Sub='SQL Server Error 6', @Msg = @err 
		--	--EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL ENC:PatientEncounter2'
		--END CATCH
	
	COMMIT
	END

END
CLOSE curEnc
DEALLOCATE curEnc

SET @surow = 'Patient Encounters2 Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient Encounters2 Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient Encounters2 Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient Encounters2',0,@day;

----UPDATE EncounterKey
--DECLARE @dt datetime
--DECLARE @key numeric(13,3)

DECLARE cur1 CURSOR FAST_FORWARD FOR
SELECT     
	PatientId, 
	AppointmentDateTime,
	EncounterKey
FROM PATIENT_ENCOUNTER 
WHERE AppointmentStatusId NOT IN (3,5,50,200,100,201,202,203,300,305,400)
	AND EncounterKey < 1
	AND AppointmentDateTime > @tempdate
	--AND PatientId = 70
	 
OPEN cur1

FETCH NEXT FROM cur1 INTO @pat,@dt,@key

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	SET @encX = 0
	BEGIN TRANSACTION
		--BEGIN TRY
		SELECT 
		@encX = EncounterKey
		FROM PATIENT_ENCOUNTER
		WHERE PatientId = @pat
		AND AppointmentDateTime = @dt
		AND AppointmentStatusId = 50
			
			
		
		IF @encX > 0	
			BEGIN
			--PRINT @pat
			--PRINT @dt
			--PRINT @key
			--PRINT @encX
			
			UPDATE PATIENT_ENCOUNTER
			SET 
			EncounterKey = @encX
			WHERE PatientId = @pat
			AND AppointmentDateTime = @dt
			AND AppointmentStatusId NOT IN (3,5,50,200,100,201,202,203,300,400)
			END
			
	FETCH NEXT FROM cur1 INTO @pat,@dt,@key
	
		--END TRY
		--BEGIN CATCH
		--	SELECT @err = 'ERROR: ETL ENC:EncounterUpdates ' + ERROR_MESSAGE();
		--	SELECT @ern = ERROR_NUMBER();
				
		--	EXEC dbo.upActivityLog @err , @ern
		--	EXEC upSendMail @Sub='SQL Server Error 7', @Msg = @err 
		--	--EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL ENC EncounterUpdates'
		--END CATCH
	
	COMMIT	
	END

END
CLOSE cur1
DEALLOCATE cur1







