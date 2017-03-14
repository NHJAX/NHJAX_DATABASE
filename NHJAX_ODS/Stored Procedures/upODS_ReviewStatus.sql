
CREATE PROCEDURE [dbo].[upODS_ReviewStatus] AS

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
Declare @loop int
Declare @exists int

Declare @key numeric(8,3)
Declare @desc varchar(30)
Declare @disp varchar(24)

Declare @keyX numeric(8,3)
Declare @descX varchar(30)
Declare @dispX varchar(24)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Review Status',0,@day;
Select Identity(int,1,1) ID,
	KEY_ORDER_APPOINTMENT_REVIEW_STATUS, 
	[NAME], 
	TASK_STATUS_DISPLAY
	into #Temp 
	FROM vwMDE_ORDER_APPOINTMENT_REVIEW_STATUS

SET @loop = @@rowcount

SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @key = KEY_ORDER_APPOINTMENT_REVIEW_STATUS, 
	@desc = [NAME], 
	@disp = TASK_STATUS_DISPLAY
	from #Temp 
	Where ID = @trow
		
	Select @keyX = ReviewStatusKey, 
	@descX = ReviewStatusDesc, 
	@dispX = ReviewStatusDisplay
	from NHJAX_ODS.dbo.REVIEW_STATUS 
	Where ReviewStatusKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.REVIEW_STATUS(ReviewStatusKey,
			ReviewStatusDesc, 
			ReviewStatusDisplay) 
		VALUES(@key, 
			@desc, 
			@disp);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @desc <> @descX
		OR @disp <> @dispX
		OR (@desc Is Not Null AND @descX Is Null)
		OR (@disp Is Not Null AND @dispX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.REVIEW_STATUS
			SET ReviewStatusDesc = @desc,
			ReviewStatusDisplay = @disp,
			UpdatedDate = GETDATE()
			WHERE ReviewStatusKey = @key;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Review Status Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Review Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Review Status Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Review Status',0,@day;
Drop table #Temp
