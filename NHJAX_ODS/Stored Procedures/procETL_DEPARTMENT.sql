
create PROCEDURE [dbo].[procETL_DEPARTMENT] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_DEPARTMENT_AND_SERVICE

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'DEPARTMENT_AND_SERVICE'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.DEPARTMENT_AND_SERVICE

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: DEPARTMENT_AND_SERVICE was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: DEPARTMENT_AND_SERVICE had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'DEPARTMENT_AND_SERVICE'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK DepartmentandService'
END CATCH

BEGIN TRY
if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END

Declare @deptkey decimal
Declare @deptdesc varchar(34)
Declare @deptabbv varchar(5)

Declare @deptkeyX decimal
Declare @deptdescX varchar(34)
Declare @deptabbvX varchar(5)

Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

EXEC dbo.upActivityLog 'Begin Department',0;
Select Identity(int,1,1) ID,
	KEY_DEPARTMENT_AND_SERVICE, 
	NAME, 
	ABBREVIATION
	into #Temp 
	FROM vwMDE_DEPARTMENT_AND_SERVICE
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @deptkey = KEY_DEPARTMENT_AND_SERVICE, 
	@deptdesc = NAME, 
	@deptabbv = ABBREVIATION
	from #Temp 
	Where ID = @trow
		
	Select @deptkeyX = DepartmentKey, 
	@deptdescX = DepartmentDesc, 
	@deptabbvX = DepartmentAbbrev
	from DEPARTMENT 
	Where DepartmentKey = @deptkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO DEPARTMENT(DepartmentKey,
			DepartmentDesc, 
			DepartmentAbbrev) 
		VALUES(@deptkey, 
			@deptdesc, 
			@deptabbv);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @deptdesc <> @deptdescX
		OR @deptabbv <> @deptabbvX
		OR (@deptdesc Is Not Null AND @deptdescX Is Null)
		OR (@deptabbv Is Not Null AND @deptabbvX Is Null)
			BEGIN
			UPDATE DEPARTMENT
			SET DepartmentDesc = @deptdesc,
			DepartmentAbbrev = @deptabbv,
			UpdatedDate = @today
			WHERE DepartmentKey = @deptkey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Department Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Department Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Department Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Department',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL Department'
END CATCH