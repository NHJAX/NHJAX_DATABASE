

CREATE PROCEDURE [dbo].[upODS_OrderType] AS
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
Declare @ordtypekey decimal
Declare @ordtypedesc varchar(4)
Declare @ordtypekeyX decimal
Declare @ordtypedescX varchar(4)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Order Type',0,@day;
Select Identity(int,1,1) ID,
	KEY_ORDER_TYPE, 
	NAME
	into #Temp 
	FROM vwMDE_ORDER_TYPE
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @ordtypekey = KEY_ORDER_TYPE, 
	@ordtypedesc = NAME
	from #Temp 
	Where ID = @trow
		
	Select @ordtypekeyX = OrderTypeKey,  
	@ordtypedescX = OrderTypeDesc
	from NHJAX_ODS.dbo.ORDER_TYPE 
	Where OrderTypeKey = @ordtypekey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.ORDER_TYPE(OrderTypeKey,
			OrderTypeDesc) 
		VALUES(@ordtypekey, 
			@ordtypedesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @ordtypedesc <> @ordtypedescX
		OR (@ordtypedesc Is Not Null AND @ordtypedescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ORDER_TYPE
			SET
			OrderTypeDesc = @ordtypedesc,
			UpdatedDate = @today
			WHERE OrderTypeKey = @ordtypekey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Order Type Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Order Type Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Order Type Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Order Type',0,@day;
Drop table #Temp

