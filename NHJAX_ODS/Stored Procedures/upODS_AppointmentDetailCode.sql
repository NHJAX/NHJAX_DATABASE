
CREATE PROCEDURE [dbo].[upODS_AppointmentDetailCode] AS

Declare @key numeric(9,3)
Declare @code varchar(8)
Declare @desc varchar(75)
Declare @inac bit

Declare @keyX numeric(9,3)
Declare @codeX varchar(8)
Declare @descX varchar(75)
Declare @inacX bit

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

EXEC dbo.upActivityLog 'Begin Appointment Detail',0,@day;


DECLARE curDtl CURSOR FAST_FORWARD FOR
SELECT     
	KEY_APPOINTMENT_DETAIL_CODES, 
	CODE, 
	DESCRIPTION, 
	CASE
		WHEN STATUS = 'ACTIVE' THEN 0
		ELSE 1
	END AS Inactive
FROM    vwMDE_APPOINTMENT_DETAIL_CODES

OPEN curDtl
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Appointment Detail',0

FETCH NEXT FROM curDtl INTO @key,@code,@desc,@inac

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@keyX = AppointmentDetailKey,
			@codeX = AppointmentDetailCode,
			@descX = AppointmentDetailDesc,
			@inacX = Inactive
		FROM NHJAX_ODS.dbo.APPOINTMENT_DETAIL_CODE
		WHERE AppointmentDetailKey = @key

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.APPOINTMENT_DETAIL_CODE(
				AppointmentDetailKey,
				AppointmentDetailCode,
				AppointmentDetailDesc,
				Inactive)
				VALUES(@key,@code,@desc,@inac);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@code <> @codeX
		OR	@desc <> @descX
		OR 	@inac <> @inacX
		OR	(@code Is Not Null AND @codeX Is Null)
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@inac Is Not Null AND @inacX Is Null)

			BEGIN
			UPDATE NHJAX_ODS.dbo.APPOINTMENT_DETAIL_CODE
			SET 	AppointmentDetailCode = @code,
				AppointmentDetailDesc = @desc,
				Inactive = @inac,
				UpdatedDate = getdate()
			WHERE AppointmentDetailKey = @key;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curDtl INTO @key,@code,@desc,@inac
	END
COMMIT
END


CLOSE curDtl
DEALLOCATE curDtl

SET @surow = 'Appointment Detail Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Appointment Detail Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Appointment Detail Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Appointment Detail',0,@day;
