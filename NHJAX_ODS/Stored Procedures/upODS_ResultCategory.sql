
CREATE PROCEDURE [dbo].[upODS_ResultCategory] AS

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

Declare @reskey numeric(21,3)
Declare @resdesc varchar(80)
Declare @rescode varchar(40)
Declare @resnum numeric(9,3)

Declare @reskeyX numeric(21,3)
Declare @resdescX varchar(80)
Declare @rescodeX varchar(40)
Declare @resnumX numeric(9,3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Result Category',0,@day;
Select Identity(int,1,1) ID,
	KEY_RESULT_CATEGORY, 
	NUMBER_, 
	DIAGNOSTIC_CODE,
	DESCRIPTION
	into #Temp 
	FROM vwMDE_RESULT_CATEGORY
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @reskey = KEY_RESULT_CATEGORY, 
	@resdesc = DESCRIPTION, 
	@rescode = DIAGNOSTIC_CODE,
	@resnum = NUMBER_
	from #Temp 
	Where ID = @trow
		
	Select @reskeyX = ResultCategoryKey, 
	@resdescX = ResultCategoryDesc, 
	@rescodeX = DiagnosticCode,
	@resnumX = ResultCategoryNumber
	from NHJAX_ODS.dbo.RESULT_CATEGORY 
	Where ResultCategoryKey = @reskey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.RESULT_CATEGORY(ResultCategoryId,
			ResultCategoryKey,
			ResultCategoryDesc, 
			DiagnosticCode,
			ResultCategoryNumber) 
		VALUES(CAST(@reskey AS bigint),
			@reskey, 
			@resdesc, 
			@rescode,
			@resnum);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @resdesc <> @resdescX
		OR @rescode <> @rescodeX
		OR @resnum <> @resnumX
		OR (@resdesc Is Not Null AND @resdescX Is Null)
		OR (@rescode Is Not Null AND @rescodeX Is Null)
		OR (@resnum Is Not Null AND @resnumX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.RESULT_CATEGORY
			SET ResultCategoryDesc = @resdesc,
			DiagnosticCode = @rescode,
			ResultCategoryNumber = @resnum,
			UpdatedDate = @today
			WHERE ResultCategoryKey = @reskey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Result Category Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Result Category Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Result Category Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Result Category',0,@day;
Drop table #Temp
