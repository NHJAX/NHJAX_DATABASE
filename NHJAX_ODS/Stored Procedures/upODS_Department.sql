
CREATE PROCEDURE [dbo].[upODS_Department] AS

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
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Department',0,@day;
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
	from NHJAX_ODS.dbo.DEPARTMENT 
	Where DepartmentKey = @deptkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.DEPARTMENT(DepartmentKey,
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
			UPDATE NHJAX_ODS.dbo.DEPARTMENT
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
EXEC dbo.upActivityLog 'End Department',0,@day;
Drop table #Temp
