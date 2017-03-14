
CREATE PROCEDURE [dbo].[upODS_AdmissionType] AS

Declare @type numeric(10,3)
Declare @code varchar(5)
Declare @desc varchar(30)

Declare @typeX numeric(10,3)
Declare @codeX varchar(5)
Declare @descX varchar(30)

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

EXEC dbo.upActivityLog 'Begin Admission Type',0,@day;

SET @today = getdate()

DECLARE curAdm CURSOR FAST_FORWARD FOR
SELECT	KEY_SOURCE_OF_ADMISSION,
	CODE,
	NAME
FROM	vwMDE_SOURCE_OF_ADMISSION


OPEN curAdm
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Admission Type',0

FETCH NEXT FROM curAdm INTO @type,@code,@desc

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@typeX = AdmissionTypeKey,
			@codeX = AdmissionTypeCode,
			@descX = AdmissionTypeDesc
		FROM NHJAX_ODS.dbo.ADMISSION_TYPE
		WHERE AdmissionTypeKey = @type

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ADMISSION_TYPE(
				AdmissionTypeKey,
				AdmissionTypeCode,
				AdmissionTypeDesc)
				VALUES(@type,@code,@desc);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@code <> @codeX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@code Is Not Null AND @codeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ADMISSION_TYPE
			SET 	AdmissionTypeCode = @code,
				AdmissionTypeDesc = @desc,
				UpdatedDate = @today
			WHERE AdmissionTypeKey = @type;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAdm INTO @type,@code,@desc
	COMMIT
	END

END


CLOSE curAdm
DEALLOCATE curAdm

SET @surow = 'Admission Type Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Admission Type Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Admission Type Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Admission Type',0,@day;
