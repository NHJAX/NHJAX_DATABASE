
CREATE PROCEDURE [dbo].[procETL_BENEFITS_CATEGORY] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_MCP_BENEFICIARY_CATEGORIES

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'MCP_BENEFICIARY_CATEGORIES'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.MCP_BENEFICIARY_CATEGORIES

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: MCP_BENEFICIARY_CATEGORIES was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: MCP_BENEFICIARY_CATEGORIES had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'MCP_BENEFICIARY_CATEGORIES'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK McpBeneficiariesCategories'
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

Declare @benkey numeric(8,3)
Declare @bendesc varchar(30)
Declare @bencode varchar(30)

Declare @benkeyX numeric(8,3)
Declare @bendescX varchar(30)
Declare @bencodeX varchar(30)

EXEC dbo.upActivityLog 'Begin BenCaty',0;
Select Identity(int,1,1) ID,
	KEY_MCP_BENEFICIARY_CATEGORIES, 
	DESCRIPTION, 
	CODE
	into #Temp 
	FROM vwMDE_MCP_BENEFICIARY_CATEGORIES
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @benkey = KEY_MCP_BENEFICIARY_CATEGORIES, 
	@bendesc = DESCRIPTION, 
	@bencode = CODE
	from #Temp 
	Where ID = @trow
		
	SELECT @benkeyX = BenefitsCategoryKey, 
		@bendescX = BenefitsCategoryDesc, 
		@bencodeX = BenefitsCategoryCode
	FROM BENEFITS_CATEGORY 
	WHERE BenefitsCategoryKey = @benkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO BENEFITS_CATEGORY(BenefitsCategoryKey,
			BenefitsCategoryDesc, 
			BenefitsCategoryCode) 
		VALUES(@benkey, 
			@bendesc, 
			@bencode);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @bendesc <> @bendescX
		OR @bencode <> @bencodeX
		OR (@bendesc Is Not Null AND @bendescX Is Null)
		OR (@bencode Is Not Null AND @bencodeX Is Null)
			BEGIN
			UPDATE dbo.BENEFITS_CATEGORY
			SET BenefitsCategoryDesc = @bendesc,
			BenefitsCategoryCode = @bencode,
			UpdatedDate = @today
			WHERE BenefitsCategoryKey = @benkey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'BenCat Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'BenCat Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'BenCat Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End BenCat',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL BenCat'
END CATCH