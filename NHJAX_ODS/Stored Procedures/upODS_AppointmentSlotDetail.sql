
CREATE PROCEDURE [dbo].[upODS_AppointmentSlotDetail] AS

Declare @slot bigint
Declare @dtl bigint
Declare @code numeric(7,3)

Declare @slotX bigint
Declare @dtlX bigint
Declare @codeX numeric(7,3)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Appt Slot Dtl',0,@day;

DECLARE curSlotDtl CURSOR FAST_FORWARD FOR
SELECT	SLOT.AppointmentSlotId, 
	CODE.AppointmentDetailId, 
	IsNull(DTL.KEY_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_C,0)
FROM    APPOINTMENT_SLOT SLOT 
	INNER JOIN vwMDE_SCHEDULABL$SCHEDULE_D$APPOINTMEN$APPT_DETAIL_CODES DTL 
	ON SLOT.SchedulableEntityKey = DTL.KEY_SCHEDULABLE_ENTITY 
	AND SLOT.AppointmentSlotKey = DTL.KEY_SCHEDULABLE_ENT$SCHEDULE_DATE_T$APPOINTMENT_SL 
	AND SLOT.AppointmentSlotDateTimeKey = DTL.KEY_SCHEDULABLE_ENTITY$SCHEDULE_DATE_TIMES 
	INNER JOIN APPOINTMENT_DETAIL_CODE CODE 
	ON DTL.APPT_DETAIL_CODES_IEN = CODE.AppointmentDetailKey

OPEN curSlotDtl
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Appt Slot Dtl',0

FETCH NEXT FROM curSlotDtl INTO @slot,@dtl, @code

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT 	@codeX = AppointmentSlotDetailKey
		FROM NHJAX_ODS.dbo.APPOINTMENT_SLOT_DETAIL
		WHERE 	AppointmentSlotId = @slot
		AND	AppointmentDetailId = @dtl

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.APPOINTMENT_SLOT_DETAIL(
				AppointmentSlotId,AppointmentDetailId,AppointmentSlotDetailKey)
				VALUES(@slot,@dtl,@code);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curSlotDtl INTO @slot,@dtl,@code
	END
COMMIT
END

CLOSE curSlotDtl
DEALLOCATE curSlotDtl

SET @sirow = 'Appt Slot Dtl Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appt Slot Dtl Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appt Slot Dtl',0,@day;
