
CREATE PROCEDURE [dbo].[procETL_BRANCH_OF_SERVICE] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_BRANCH_OF_SERVICE

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'BRANCH_OF_SERVICE'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.BRANCH_OF_SERVICE

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: BRANCH_OF_SERVICE was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: BRANCH_OF_SERVICE had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'BRANCH_OF_SERVICE'

if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK BranchofService'
END CATCH

BEGIN TRY
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

EXEC dbo.upActivityLog 'Begin Branch of Service',0;

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
	from BRANCH_OF_SERVICE 
	Where BranchofServiceKey = @branchkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO BRANCH_OF_SERVICE(BranchofServiceKey,
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
			UPDATE BRANCH_OF_SERVICE
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
EXEC dbo.upActivityLog 'End Branch of Service',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL BranchofService'
END CATCH