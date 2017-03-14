
CREATE PROCEDURE [dbo].[upODS_PatientDisposition] AS
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

Declare @dispkey decimal
Declare @dispcode varchar(4)
Declare @dispdesc varchar(30)

Declare @dispkeyX decimal
Declare @dispcodeX varchar(4)
Declare @dispdescX varchar(30)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Patient Disposition',0,@day;

Select Identity(int,1,1) ID,
	KEY_OUTPATIENT_DISPOSITION, 
	CODE, 
	DESCRIPTION
	into #Temp 
	FROM vwMDE_OUTPATIENT_DISPOSITION

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @dispkey = KEY_OUTPATIENT_DISPOSITION, 
	@dispcode = CODE, 
	@dispdesc = DESCRIPTION
	from #Temp 
	Where ID = @trow
		
	Select @dispkeyX = PatientDispositionKey, 
	@dispcodeX = PatientDispositionCode, 
	@dispdescX = PatientDispositionDesc
	from NHJAX_ODS.dbo.PATIENT_DISPOSITION 
	Where PatientDispositionKey = @dispkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PATIENT_DISPOSITION(PatientDispositionKey,
			PatientDispositionCode, 
			PatientDispositionDesc) 
		VALUES(@dispkey, 
			@dispcode, 
			@dispdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @dispcode <> @dispcodeX
		OR @dispdesc <> @dispdescX
		OR (@dispcode Is Not Null AND @dispcodeX Is Null)
		OR (@dispdesc Is Not Null AND @dispdescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.PATIENT_DISPOSITION
			SET PatientDispositionCode = @dispcode,
			PatientDispositionDesc = @dispdesc,
			UpdatedDate = @today
			WHERE PatientDispositionKey = @dispkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Patient Disposition Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient Disposition Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient Disposition Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient Disposition',0,@day;
Drop table #Temp
