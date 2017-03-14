



CREATE PROCEDURE [dbo].[upEDPTS_PatientEncounter] AS

Declare @appt decimal
Declare @pat bigint
Declare @date datetime
Declare @loc bigint
Declare @pro bigint
Declare @duration decimal
Declare @stat bigint
Declare @reason varchar(80)
Declare @ac bigint
Declare @enc decimal
Declare @disp bigint
Declare @drel datetime
Declare @pri bigint
Declare @reas int
Declare @rel bigint

Declare @apptX decimal
Declare @patX decimal
Declare @dateX datetime
Declare @locX bigint
Declare @proX bigint
Declare @durationX decimal
Declare @statX bigint
Declare @reasonX varchar(80)
Declare @acX bigint
Declare @encX decimal
Declare @dispX bigint
Declare @drelX datetime
Declare @priX bigint
Declare @reasX int
Declare @relX bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin EDPTS Patient Encounters',5;
SET @tempDate = DATEADD(d,-5,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE curAppt CURSOR FAST_FORWARD FOR
SELECT  DISTINCT   
	KEY_PATIENT_APPOINTMENT, 
	PatientId, 
	APPOINTMENT_DATE_TIME, 
	HospitalLocationId, 
	ProviderId, 
	DURATION, 
	AppointmentStatusId,
	REASON_FOR_APPOINTMENT, 
	ArrivalCategoryId,
	ENCOUNTER_PTR_IEN,
	PatientDispositionId,
	DATETIME_OF_RELEASE,
	PriorityId,
	ReasonSeenId,
	CASE RELEASE_CONDITION
		WHEN 'I' THEN 1
		WHEN 'U' THEN 2
		ELSE 0
	END AS ReleaseConditionId 
FROM         
	dbo.vwEDPTS_PATIENT_APPOINTMENT
WHERE     (APPOINTMENT_DATE_TIME >= @fromDate) 


OPEN curAppt
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch EDPTS Patient Encounters',5
FETCH NEXT FROM curAppt INTO @appt,@pat,@date,@loc,@pro,@duration,@stat,
	@reason,@ac,@enc,@disp,@drel,@pri,@reas,@rel
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		
		Select 	
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
			@drelX = ReleaseDateTime,
			@priX = PriorityId,
			@acX = ArrivalCategoryId,
			@reasX = ReasonSeenId,
			@relX = ReleaseConditionId
		FROM NHJAX_ODS.dbo.PATIENT_ENCOUNTER
		WHERE PatientAppointmentKey = @appt
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN

				INSERT INTO NHJAX_ODS.dbo.PATIENT_ENCOUNTER(
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
				DischargeDateTime,
				PriorityId,
				ArrivalCategoryId,
				ReasonSeenId,
				ReleaseConditionId,
				ReleaseDateTime,
				DMISId,
				SourceSystemId)
				VALUES(@appt,@pat,@date,@loc,@pro,@duration,
				@stat,@reason,@disp,@enc,@drel,@pri,@ac,@reas,@rel,@drel,1527,9);
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
		OR	@drel <> @drelX
		OR	@pri <> @priX
		OR	@ac <> @acX
		OR	@reas <> @reasX
		OR	@rel <> @relX
		OR 	(@pat Is Not Null AND @patX Is Null)
		OR 	(@date Is Not Null AND @dateX Is Null)
		OR 	(@loc Is Not Null AND @locX Is Null)
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@duration Is Not Null AND @durationX Is Null)
		OR 	(@stat Is Not Null AND @statX Is Null)
		OR 	(@reason Is Not Null AND @reasonX Is Null)
		OR 	(@disp Is Not Null AND @dispX Is Null)
		OR	(@enc Is Not Null AND @encX Is Null)
		OR	(@drel Is Not Null AND @drelX Is Null)
		OR	(@pri Is Not Null AND @priX Is Null)
		OR	(@ac Is Not Null AND @acX Is Null)
		OR	(@reas Is Not Null AND @reasX Is Null)
		OR	(@rel Is Not Null AND @relX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PATIENT_ENCOUNTER
			SET 	PatientId = @pat,
				AppointmentDateTime = @date,
				HospitalLocationId = @loc,
				ProviderId = @pro,
				Duration = @duration,
				AppointmentStatusId = @stat,
				ReasonForAppointment = @reason,
				PatientDispositionId = @disp,
				EncounterKey = @enc,
				ReleaseDateTime = @drel,
				PriorityId = @pri,
				ArrivalCategoryId = @ac,
				ReasonSeenId = @reas,
				ReleaseConditionId = @rel,
				UpdatedDate = @today
			WHERE PatientAppointmentKey = @appt;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1

		FETCH NEXT FROM curAppt INTO @appt,@pat,@date,@loc,@pro,@duration,@stat,
	@reason,@ac,@enc,@disp,@drel,@pri,@reas,@rel
	COMMIT
	END

END
CLOSE curAppt
DEALLOCATE curAppt
SET @surow = 'Patient EDPTS Encounters Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient EDPTS Encounters Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient EDPTS Encounters Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,5;
EXEC dbo.upActivityLog @sirow,5;
EXEC dbo.upActivityLog @strow,5;
EXEC dbo.upActivityLog 'End EDPTS Patient Encounters',5;

