
CREATE PROCEDURE [dbo].[procETL_APPOINTMENT_SLOT_STATUS] AS

BEGIN TRY
Declare @status varchar(30)
Declare @statusX varchar(30)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
EXEC dbo.upActivityLog 'Begin Appt Slot Status',0

DECLARE curStat CURSOR FAST_FORWARD FOR
	SELECT DISTINCT STAT.APPT_SLOT_STATUS
	FROM vwMDE_Schedulable_ent$schedule_date_t$appointment_slots STAT
	WHERE STAT.APPT_SLOT_STATUS IS NOT NULL
OPEN curStat
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM curStat INTO @status
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @statusX = AppointmentSlotStatusDesc FROM APPOINTMENT_SLOT_STATUS
			WHERE AppointmentSlotStatusDesc = @status

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO APPOINTMENT_SLOT_STATUS(AppointmentSlotStatusDesc)
					VALUES(@status);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM curStat INTO @status
	COMMIT	
	END
	
END
CLOSE curStat
DEALLOCATE curStat
SET @sirow = 'Appt Slot Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appt Slot Status Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Appt Slot Status',0
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL ApptSlotStatus'
END CATCH