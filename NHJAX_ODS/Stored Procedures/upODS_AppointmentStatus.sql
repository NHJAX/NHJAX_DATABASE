
CREATE PROCEDURE [dbo].[upODS_AppointmentStatus] AS
if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END

Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @statkey decimal
Declare @statdesc varchar(30)

Declare @statkeyX decimal
Declare @statdescX varchar(30)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Appointment Status',0,@day;

Select Identity(int,1,1) ID,
	KEY_APPOINTMENT_STATUS, 
	APPOINTMENT_STATUS
	into #Temp 
	FROM vwMDE_APPOINTMENT_STATUS
	ORDER BY KEY_APPOINTMENT_STATUS

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION	
	Select @statkey = KEY_APPOINTMENT_STATUS, 
	@statdesc = APPOINTMENT_STATUS
	from #Temp 
	Where ID = @trow
		
	Select @statkeyX = AppointmentStatusKey, 
	@statdescX = AppointmentStatusDesc
	from NHJAX_ODS.dbo.APPOINTMENT_STATUS
	Where AppointmentStatusKey = @statkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.APPOINTMENT_STATUS(AppointmentStatusKey, 
			AppointmentStatusDesc) 
		VALUES(@statkey, 
			@statdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @statdesc <> @statdescX
		OR (@statdesc Is Not Null AND @statdescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.APPOINTMENT_STATUS
			SET AppointmentStatusDesc = @statdesc,
			UpdatedDate = @today
			WHERE AppointmentStatusKey = @statkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Appointment Status Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Appointment Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appointment Status Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appointment Status',0,@day;
Drop table #Temp
