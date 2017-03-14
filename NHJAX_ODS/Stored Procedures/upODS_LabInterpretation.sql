
CREATE PROCEDURE [dbo].[upODS_LabInterpretation] AS
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

Declare @key numeric(7,3)
Declare @desc varchar(30)
Declare @code varchar(2)

Declare @keyX numeric(7,3)
Declare @descX varchar(30)
Declare @codeX varchar(2)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Lab Interpretation',0,@day;

Select Identity(int,1,1) ID,
	KEY_LAB_INTERPRETATION_FILE, 
	CODE, 
	DESCRIPTION
	into #Temp 
	FROM vwMDE_LAB_INTERPRETATION_FILE

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @key = KEY_LAB_INTERPRETATION_FILE, 
	@desc = DESCRIPTION, 
	@code = CODE
	from #Temp 
	Where ID = @trow
		
	Select @keyX = LabInterpretationKey, 
	@descX = LabInterpretationDesc, 
	@codeX = LabInterpretationCode
	from NHJAX_ODS.dbo.LAB_INTERPRETATION 
	Where LabInterpretationKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.LAB_INTERPRETATION(LabInterpretationKey,
			LabInterpretationDesc, 
			LabInterpretationCode) 
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
			UPDATE NHJAX_ODS.dbo.LAB_INTERPRETATION
			SET LabInterpretationDesc = @desc,
			LabInterpretationCode = @code,
			UpdatedDate = @today
			WHERE LabInterpretationKey = @key;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Lab Interpretation Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Lab Interpretation Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Interpretation Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Lab Interpretation',0,@day;
Drop table #Temp

