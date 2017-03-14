
CREATE PROCEDURE [dbo].[upODS_AppointmentType] AS

Declare @type numeric(10,3)
Declare @code varchar(5)
Declare @desc varchar(30)
Declare @stat bit

Declare @typeX numeric(10,3)
Declare @codeX varchar(5)
Declare @descX varchar(30)
Declare @statX bit

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Appt Type',0,@day;

SET @today = getdate()

DECLARE curApptType CURSOR FAST_FORWARD FOR
SELECT	KEY_APPOINTMENT_TYPE,
	NAME,
	DESCRIPTION,
	CASE STATUS
		WHEN 'ACTIVE' THEN 0
		ELSE 1
	END AS Inactive
FROM	vwMDE_APPOINTMENT_TYPE


OPEN curApptType
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Appt Type',0

FETCH NEXT FROM curApptType INTO @type,@code,@desc,@stat

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@typeX = AppointmentTypeKey,
			@codeX = AppointmentTypeCode,
			@descX = AppointmentTypeDesc,
			@statX = Inactive
		FROM NHJAX_ODS.dbo.APPOINTMENT_TYPE
		WHERE AppointmentTypeKey = @type

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.APPOINTMENT_TYPE(
				AppointmentTypeKey,
				AppointmentTypeCode,
				AppointmentTypeDesc,
				Inactive)
				VALUES(@type,@code,@desc,@stat);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@code <> @codeX
		OR  @stat <> @statX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@code Is Not Null AND @codeX Is Null)
		OR	(@stat Is Not Null AND @statX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.APPOINTMENT_TYPE
			SET	AppointmentTypeCode = @code,
				AppointmentTypeDesc = @desc,
				Inactive = @stat,
				UpdatedDate = @today
			WHERE AppointmentTypeKey = @type;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curApptType INTO @type,@code,@desc,@stat
	COMMIT
	END

END


CLOSE curApptType
DEALLOCATE curApptType

SET @surow = 'Appt Type Updated' + CAST(@urow AS varchar(50))
SET @sirow = 'Appt Type Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appt Type Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appt Type',0,@day;
