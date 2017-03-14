


CREATE PROCEDURE [dbo].[upODS_AppointmentSlot] AS

Declare @sekey numeric(11,3)
Declare @askey numeric(14,3)
Declare @dtkey numeric(22,7)
Declare @dttm datetime
Declare @loc bigint
Declare @pro bigint
Declare @stat bigint
Declare @type bigint

Declare @sekeyX numeric(11,3)
Declare @askeyX numeric(14,3)
Declare @dtkeyX numeric(22,7)
Declare @dttmX datetime
Declare @locX bigint
Declare @proX bigint
Declare @statX bigint
Declare @typeX bigint

Declare @slotid bigint
Declare @slotdate datetime

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Appointment Slot',0,@day;
 
/*SET @today = getdate()*/

DECLARE curSlot CURSOR FAST_FORWARD FOR
SELECT	SLOTS.KEY_SCHEDULABLE_ENTITY, 
		SLOTS.KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL, 
        		SLOTS.KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES, 
		TIMES.DATE_TIME, 
		ISNULL(STAT.AppointmentSlotStatusId, 0) AS AppointmentSlotStatusId, 
		ISNULL(HOSP.HospitalLocationId, 0) AS HospitalLocationId, 
		ISNULL(PRO.ProviderId, 0) AS ProviderId, 
        		ISNULL(APPOINTMENT_TYPE.AppointmentTypeId, 0) AS AppointmentTypeId
FROM    vwMDE_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SLOTS SLOTS 
	INNER JOIN vwMDE_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES TIMES 
	ON SLOTS.KEY_SCHEDULABLE_ENTITY = TIMES.KEY_SCHEDULABLE_ENTITY 
	AND SLOTS.KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES = TIMES.KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES 
	LEFT OUTER JOIN APPOINTMENT_TYPE 
	ON SLOTS.APPOINTMENT_TYPE_IEN = APPOINTMENT_TYPE.AppointmentTypeKey 
	LEFT OUTER JOIN PROVIDER PRO 
	ON SLOTS.PROVIDER_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN HOSPITAL_LOCATION HOSP 
	ON SLOTS.CLINIC_IEN = HOSP.HospitalLocationKey 
	LEFT OUTER JOIN APPOINTMENT_SLOT_STATUS STAT 
	ON SLOTS.APPT_SLOT_STATUS = STAT.AppointmentSlotStatusDesc

OPEN curSlot
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch Appointment Slot',0
FETCH NEXT FROM curSlot INTO @sekey,@askey,@dtkey,@dttm,@stat,@loc,@pro,@type
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@dttmX = AppointmentSlotDateTime,
			@statX = AppointmentSlotStatusId,
			@locX = HospitalLocationId,
			@proX = ProviderId,
			@typeX = AppointmentTypeId
		FROM NHJAX_ODS.dbo.APPOINTMENT_SLOT
		WHERE SchedulableEntityKey = @sekey
		AND AppointmentSlotKey = @askey
		AND AppointmentSlotDateTimeKey = @dtkey;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.APPOINTMENT_SLOT(
				SchedulableEntityKey,
				AppointmentSlotKey,
				AppointmentSlotDateTimeKey,
				AppointmentSlotDateTime,
				AppointmentSlotStatusId,
				HospitalLocationId,
				ProviderId,
				AppointmentTypeId)
				VALUES(@sekey,@askey,@dtkey,@dttm,@stat,@loc,@pro,@type);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@dttm <> @dttmX
		OR	@stat <> @statX
		OR	@loc <> @locX
		OR	@pro <> @proX
		OR	@type <> @typeX
		OR 	(@dttm Is Not Null AND @dttmX Is Null)
		OR 	(@stat Is Not Null AND @statX Is Null)
		OR 	(@loc Is Not Null AND @locX Is Null)
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR	(@type Is Not Null AND @typeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.APPOINTMENT_SLOT
			SET 	AppointmentSlotDateTime = @dttm,
				AppointmentSlotStatusId = @stat,
				HospitalLocationId = @loc,
				ProviderId = @pro,
				AppointmentTypeId = @type,
				UpdatedDate = getdate()
			WHERE SchedulableEntityKey = @sekey
			AND AppointmentSlotKey = @askey
			AND AppointmentSlotDateTimeKey = @dtkey;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curSlot INTO @sekey,@askey,@dtkey,@dttm,@stat,@loc,@pro,@type
	COMMIT	
	END
END
CLOSE curSlot
DEALLOCATE curSlot

--Delete any missing records
EXEC dbo.upActivityLog 'Begin Del Appointment Slot',0,@day;

Declare @minSlotDate datetime
Declare @maxSlotDate datetime

SET @minSlotDate = dbo.minSlotDate();
SET @maxSlotDate = dbo.maxSlotDate();

DECLARE curDelSlot CURSOR FOR
SELECT  SLOT.AppointmentSlotId, SLOT.AppointmentSlotDateTime
FROM    APPOINTMENT_SLOT SLOT 
	LEFT OUTER JOIN vwMDE_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SLOTS CDSS_SLOT 
	ON SLOT.SchedulableEntityKey = CDSS_SLOT.KEY_SCHEDULABLE_ENTITY 
	AND SLOT.AppointmentSlotDateTimeKey = CDSS_SLOT.KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES 
	AND SLOT.AppointmentSlotKey = CDSS_SLOT.KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL
WHERE   (CDSS_SLOT.KEY_SCHEDULABLE_ENTITY IS NULL)


OPEN curDelSlot
EXEC dbo.upActivityLog 'Fetch Del Appointment Slot',0

FETCH NEXT FROM curDelSlot INTO @slotid,@slotdate

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		--PRINT @slotdate
		--PRINT @minSlotDate
		--Print @maxSlotDate
		
		if(@slotdate >= @minSlotDate AND @slotdate <= @maxSlotDate)
		
		BEGIN
			DELETE FROM NHJAX_ODS.dbo.APPOINTMENT_SLOT
			WHERE AppointmentSlotId = @slotid;
			SET @drow = @drow + 1
		END
		
		FETCH NEXT FROM curDelSlot INTO @slotid,@slotdate
	COMMIT
	END
END

CLOSE curDelSlot
DEALLOCATE curDelSlot


SET @surow = 'Appointment Slot Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Appointment Slot Inserted: ' + CAST(@irow AS varchar(50))
Set @sdrow = 'Appointment Slot Deleted: ' + CAST(@drow AS varchar(50))
SET @strow = 'Appointment Slot Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Del Appointment Slot',0,@day;
EXEC dbo.upActivityLog 'End Appointment Slot',0,@day;


