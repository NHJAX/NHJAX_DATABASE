
CREATE PROCEDURE [dbo].[upODS_Branch] AS
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

Declare @branchkey decimal
Declare @branchname varchar(36)
Declare @branchcode varchar(3)

Declare @branchkeyX decimal
Declare @branchnameX varchar(36)
Declare @branchcodeX varchar(3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Branch of Service',0,@day;

Select Identity(int,1,1) ID,
	KEY_BRANCH_OF_SERVICE, 
	NAME, 
	CODE
	into #Temp 
	FROM vwMDE_BRANCH_OF_SERVICE

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @branchkey = KEY_BRANCH_OF_SERVICE, 
	@branchname = NAME, 
	@branchcode = CODE
	from #Temp 
	Where ID = @trow
		
	Select @branchkeyX = BranchofServiceKey, 
	@branchnameX = BranchofServiceDesc, 
	@branchcodeX = BranchofServiceCode
	from NHJAX_ODS.dbo.BRANCH_OF_SERVICE 
	Where BranchofServiceKey = @branchkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.BRANCH_OF_SERVICE(BranchofServiceKey,
			BranchofServiceDesc, 
			BranchofServiceCode) 
		VALUES(@branchkey, 
			@branchname, 
			@branchcode);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @branchname <> @branchnameX
		OR @branchcode <> @branchcodeX
		OR (@branchname Is Not Null AND @branchnameX Is Null)
		OR (@branchcode Is Not Null AND @branchcodeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.BRANCH_OF_SERVICE
			SET BranchofServiceDesc = @branchname,
			BranchofServiceCode = @branchcode,
			UpdatedDate = @today
			WHERE BranchofServiceKey = @branchkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Branch of Service Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Branch of Service Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Branch of Service Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Branch of Service',0,@day;
Drop table #Temp
