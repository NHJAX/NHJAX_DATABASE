
CREATE PROCEDURE [dbo].[procETL_COLLECTION_SAMPLE] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_COLLECTION_SAMPLE

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'COLLECTION_SAMPLE'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.COLLECTION_SAMPLE

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: COLLECTION_SAMPLE was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: COLLECTION_SAMPLE had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF LEN(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'COLLECTION_SAMPLE'

END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK CollectionSample'
END CATCH

BEGIN TRY
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
EXEC dbo.upActivityLog 'Begin Collection Sample',0;
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
	from COLLECTION_SAMPLE 
	Where CollectionSampleKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO COLLECTION_SAMPLE(CollectionSampleKey,
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
			UPDATE COLLECTION_SAMPLE
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
EXEC dbo.upActivityLog 'End Collection Sample',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL Collection Sample'
END CATCH
