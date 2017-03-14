
CREATE PROCEDURE [dbo].[upODS_CollectionSample] AS
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
Declare @key numeric(12,3)
Declare @desc varchar(70)
Declare @keyX numeric(12,3)
Declare @descX varchar(70)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Collection Sample',0,@day;
Select Identity(int,1,1) ID,
	KEY_COLLECTION_SAMPLE, 
	NAME
	into #Temp 
	FROM vwMDE_COLLECTION_SAMPLE
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @key = KEY_COLLECTION_SAMPLE, 
	@desc = NAME
	from #Temp 
	Where ID = @trow
		
	Select @keyX = CollectionSampleKey,  
	@descX = CollectionSampleDesc
	from NHJAX_ODS.dbo.COLLECTION_SAMPLE 
	Where CollectionSampleKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.COLLECTION_SAMPLE(CollectionSampleKey,
			CollectionSampleDesc) 
		VALUES(@key, 
			@desc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @desc <> @descX
		OR (@desc Is Not Null AND @descX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.COLLECTION_SAMPLE
			SET
			CollectionSampleDesc = @desc,
			UpdatedDate = @today
			WHERE CollectionSampleKey = @key;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Collection Sample Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Collection Sample Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Collection Sample Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Collection Sample',0,@day;
Drop table #Temp

