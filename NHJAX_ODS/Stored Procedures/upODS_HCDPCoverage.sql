
CREATE PROCEDURE [dbo].[upODS_HCDPCoverage] AS

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

Declare @key numeric(9,3)
Declare @desc varchar(125)
Declare @code varchar(3)

Declare @keyX numeric(9,3)
Declare @descX varchar(125)
Declare @codeX varchar(3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin HCDP Coverage',0,@day;
Select Identity(int,1,1) ID,
	KEY_NED_HCDP_COVERAGE_CODE, 
	[TEXT], 
	CODE
	into #Temp 
	FROM vwMDE_NED_HCDP_COVERAGE_CODE
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @key = KEY_NED_HCDP_COVERAGE_CODE, 
	@desc = [TEXT], 
	@code = CODE
	from #Temp 
	Where ID = @trow
		
	Select @keyX = HCDPCoverageKey, 
	@descX = HCDPCoverageDesc, 
	@codeX = HCDPCoverageCode
	from NHJAX_ODS.dbo.HCDP_COVERAGE 
	Where HCDPCoverageKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.HCDP_COVERAGE(HCDPCoverageKey,
			HCDPCoverageDesc, 
			HCDPCoverageCode) 
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
			UPDATE NHJAX_ODS.dbo.HCDP_COVERAGE
			SET HCDPCoverageDesc = @desc,
			HCDPCoverageCode = @code,
			UpdatedDate = @today
			WHERE HCDPCoverageKey = @key;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'HCDP Coverage Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'HCDP Coverage Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'HCDP Coverage Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End HCDP Coverage',0,@day;
Drop table #Temp
