
CREATE PROCEDURE [dbo].[upODS_PatientCoverage] AS

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

Declare @pckey numeric(9,3)
Declare @pcdesc varchar(125)
Declare @pccode varchar(3)

Declare @pckeyX numeric(9,3)
Declare @pcdescX varchar(125)
Declare @pccodeX varchar(3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Pat Coverage',0,@day;
Select Identity(int,1,1) ID,
	KEY_NED_HCDP_COVERAGE_CODE, 
	TEXT, 
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
	
	Select @pckey = KEY_NED_HCDP_COVERAGE_CODE, 
	@pcdesc = TEXT, 
	@pccode = CODE
	from #Temp 
	Where ID = @trow
		
	Select @pckeyX = PatientCoverageKey, 
	@pcdescX = PatientCoverageDesc, 
	@pccodeX = PatientCoverageCode
	from NHJAX_ODS.dbo.PATIENT_COVERAGE 
	Where PatientCoverageKey = @pckey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PATIENT_COVERAGE(PatientCoverageKey,
			PatientCoverageDesc,
			PatientCoverageCode) 
		VALUES(@pckey, 
			@pcdesc, 
			@pccode);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @pcdesc <> @pcdescX
		OR @pccode <> @pccodeX
		OR (@pcdesc Is Not Null AND @pcdescX Is Null)
		OR (@pccode Is Not Null AND @pccodeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.PATIENT_COVERAGE
			SET PatientCoverageDesc = @pcdesc,
			PatientCoverageCode = @pccode,
			UpdatedDate = @today
			WHERE PatientCoverageKey = @pckey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Pat Coverage Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Pat Coverage Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Pat Coverage Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Pat Coverage',0,@day;
Drop table #Temp
