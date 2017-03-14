
CREATE PROCEDURE [dbo].[upODS_AntibioticSusceptibility] AS
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
Declare @desc varchar(35)
Declare @abb varchar(3)

Declare @keyX numeric(9,3)
Declare @descX varchar(35)
Declare @abbX varchar(3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Antibiotic Susceptibility',0,@day;

Select Identity(int,1,1) ID,
	KEY_ANTIBIOTIC_SUSCEPTIBILITY, 
	ANTIBIOTIC, 
	ABBREVIATION
	into #Temp 
	FROM vwMDE_ANTIBIOTIC_SUSCEPTIBILITY

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @key = KEY_ANTIBIOTIC_SUSCEPTIBILITY, 
	@desc = ANTIBIOTIC, 
	@abb = ABBREVIATION
	from #Temp 
	Where ID = @trow
		
	Select @keyX = AntibioticSusceptibilityKey, 
	@descX = AntibioticSusceptibilityDesc, 
	@abbX = AntibioticSusceptibilityAbbrev
	from NHJAX_ODS.dbo.ANTIBIOTIC_SUSCEPTIBILITY 
	Where AntibioticSusceptibilityKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.ANTIBIOTIC_SUSCEPTIBILITY(AntibioticSusceptibilityKey,
			AntibioticSusceptibilityDesc, 
			AntibioticSusceptibilityAbbrev) 
		VALUES(@key, 
			@desc, 
			@abb);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @desc <> @descX
		OR @abb <> @abbX
		OR (@desc Is Not Null AND @descX Is Null)
		OR (@abb Is Not Null AND @abbX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ANTIBIOTIC_SUSCEPTIBILITY
			SET AntibioticSusceptibilityDesc = @desc,
			AntibioticSusceptibilityAbbrev = @abb,
			UpdatedDate = @today
			WHERE AntibioticSusceptibilityKey = @key;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Antibiotic Susceptibility Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Antibiotic Susceptibility Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Antibiotic Susceptibility Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Antibiotic Susceptibility',0,@day;
Drop table #Temp
