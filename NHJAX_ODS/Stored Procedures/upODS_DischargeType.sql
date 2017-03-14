
CREATE PROCEDURE [dbo].[upODS_DischargeType] AS

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

EXEC dbo.upActivityLog 'Begin Discharge Type',0,@day;

SET @today = getdate()

DECLARE curDis CURSOR FAST_FORWARD FOR
SELECT	KEY_DISCHARGE_TYPE,
	CODE,
	NAME
FROM	vwMDE_DISCHARGE_TYPE


OPEN curDis
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Discharge Type',0

FETCH NEXT FROM curDis INTO @type,@code,@desc

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@typeX = DischargeTypeKey,
			@codeX = DischargeTypeCode,
			@descX = DischargeTypeDesc
		FROM NHJAX_ODS.dbo.DISCHARGE_TYPE
		WHERE DischargeTypeKey = @type

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.DISCHARGE_TYPE(
				DischargeTypeKey,
				DischargeTypeCode,
				DischargeTypeDesc)
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
			UPDATE NHJAX_ODS.dbo.DISCHARGE_TYPE
			SET 	DischargeTypeCode = @code,
				DischargeTypeDesc = @desc,
				UpdatedDate = @today
			WHERE DischargeTypeKey = @type;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curDis INTO @type,@code,@desc
	COMMIT
	END

END


CLOSE curDis
DEALLOCATE curDis

SET @surow = 'Discharge Type Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Discharge Type Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Discharge Type Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Discharge Type',0,@day;
