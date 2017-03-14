
CREATE PROCEDURE [dbo].[upODS_BenefitsCategory] AS

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
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin BenCaty',0,@day;
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
		
	Select @benkeyX = BenefitsCategoryKey, 
	@bendescX = BenefitsCategoryDesc, 
	@bencodeX = BenefitsCategoryCode
	from NHJAX_ODS.dbo.BENEFITS_CATEGORY 
	Where BenefitsCategoryKey = @benkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.BENEFITS_CATEGORY(BenefitsCategoryKey,
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
			UPDATE NHJAX_ODS.dbo.BENEFITS_CATEGORY
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
EXEC dbo.upActivityLog 'End BenCat',0,@day;
Drop table #Temp
