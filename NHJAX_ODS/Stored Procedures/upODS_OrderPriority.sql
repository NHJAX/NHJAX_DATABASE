
CREATE PROCEDURE [dbo].[upODS_OrderPriority] AS

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

Declare @key numeric(10,4)
Declare @desc varchar(30)
Declare @code numeric(7,3)

Declare @keyX numeric(10,4)
Declare @descX varchar(30)
Declare @codeX numeric(7,3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Order Priority',0,@day;

Select Identity(int,1,1) ID,
	KEY_ORDER_PRIORITY, 
	CODE, 
	NAME
	into #Temp 
	FROM vwMDE_ORDER_PRIORITY

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @key = KEY_ORDER_PRIORITY, 
	@code = CODE, 
	@desc = NAME
	from #Temp 
	Where ID = @trow
		
	Select @keyX = OrderPriorityKey, 
	@descX = OrderPriorityDesc, 
	@codeX = OrderPriorityCode
	from NHJAX_ODS.dbo.ORDER_PRIORITY 
	Where OrderPriorityKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.ORDER_PRIORITY(OrderPriorityKey,
			OrderPriorityDesc, 
			OrderPriorityCode) 
		VALUES(@key, 
			@desc, 
			@code);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @desc <> @descX
		OR @code <> @codeX
		OR (@desc Is Not Null AND @descX Is Null)
		OR (@code Is Not Null AND @codeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ORDER_PRIORITY
			SET OrderPriorityDesc = @desc,
			OrderPriorityCode = @code,
			UpdatedDate = @today
			WHERE OrderPriorityKey = @key;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Order Priority Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Order Priority Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Order Priority Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End OrderPriority',0,@day;
Drop table #Temp
