
CREATE PROCEDURE [dbo].[upODS_PatientCategory] AS

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

Declare @pckey numeric(10,3)
Declare @pcdesc varchar(36)
Declare @pccode varchar(4)
Declare @shrt varchar(22)

Declare @pckeyX numeric(10,3)
Declare @pcdescX varchar(36)
Declare @pccodeX varchar(4)
Declare @shrtX varchar(22)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Pat Cat',0,@day;
Select Identity(int,1,1) ID,
	KEY_PATIENT_CATEGORY, 
	NAME, 
	CODE,
	SHORT_DESCRIPTION
	into #Temp 
	FROM vwMDE_PATIENT_CATEGORY 
	
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	
	Select @pckey = KEY_PATIENT_CATEGORY, 
	@pcdesc = NAME, 
	@pccode = CODE,
	@shrt = SHORT_DESCRIPTION
	from #Temp 
	Where ID = @trow
		
	Select @pckeyX = PatientCategoryKey, 
	@pcdescX = PatientCategoryDesc, 
	@pccodeX = PatientCategoryCode,
	@shrtX = ShortDescription
	from NHJAX_ODS.dbo.PATIENT_CATEGORY 
	Where PatientCategoryKey = @pckey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PATIENT_CATEGORY(PatientCategoryKey,
			PatientCategoryDesc,
			PatientCategoryCode,
			ShortDescription) 
		VALUES(@pckey, 
			@pcdesc, 
			@pccode,
			@shrt);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @pcdesc <> @pcdescX
		OR @pccode <> @pccodeX
		OR (@pcdesc Is Not Null AND @pcdescX Is Null)
		OR (@pccode Is Not Null AND @pccodeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.PATIENT_CATEGORY
			SET PatientCategoryDesc = @pcdesc,
			PatientCategoryCode = @pccode,
			UpdatedDate = @today
			WHERE PatientCategoryKey = @pckey;
			SET @urow = @urow + 1
			END
			
		IF @shrt <> @shrtX
		OR (@shrt Is Not Null AND @shrtX Is Null)
		BEGIN
			UPDATE PATIENT_CATEGORY
			SET ShortDescription = @shrt,
			UpdatedDate = GETDATE()
			WHERE PatientCategoryKey = @pckey;
			SET @urow = @urow + 1
		END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Pat Cat Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Pat Cat Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Pat Cat Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Pat Cat',0,@day;
Drop table #Temp
