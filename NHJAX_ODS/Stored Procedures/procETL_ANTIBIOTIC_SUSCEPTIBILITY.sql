
CREATE PROCEDURE [dbo].[procETL_ANTIBIOTIC_SUSCEPTIBILITY] AS


--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ANTIBIOTIC_SUSCEPTIBILITY

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ANTIBIOTIC_SUSCEPTIBILITY'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ANTIBIOTIC_SUSCEPTIBILITY

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ANTIBIOTIC_SUSCEPTIBILITY was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: ANTIBIOTIC_SUSCEPTIBILITY had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF DataLength(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'ANTIBIOTIC_SUSCEPTIBILITY'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AntibioticSusceptibility'
END CATCH

--Antibiotic Susceptibility
BEGIN TRY
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

EXEC dbo.upActivityLog 'Begin Antibiotic Susceptibility',0;

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
		INSERT INTO ANTIBIOTIC_SUSCEPTIBILITY(AntibioticSusceptibilityKey,
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
EXEC dbo.upActivityLog 'End Antibiotic Susceptibility',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AntibioticSusceptibility'
END CATCH
