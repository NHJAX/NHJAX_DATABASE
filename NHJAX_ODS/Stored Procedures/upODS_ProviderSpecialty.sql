
CREATE PROCEDURE [dbo].[upODS_ProviderSpecialty] AS
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
Declare @loop int
Declare @exists int

Declare @key decimal
Declare @desc varchar(60)
Declare @code varchar(30)

Declare @keyX decimal
Declare @descX varchar(60)
Declare @codeX varchar(30)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Provider Specialty',0,@day;

Select Identity(int,1,1) ID,
	KEY_PROVIDER_SPECIALTY, 
	CODE, 
	[DESCRIPTION]
	into #Temp 
	FROM vwMDE_PROVIDER_SPECIALTY
SET @loop = @@rowcount

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @key = KEY_PROVIDER_SPECIALTY, 
	@desc = [DESCRIPTION], 
	@code = CODE
	from #Temp 
	Where ID = @trow
		
	Select @keyX = ProviderSpecialtyKey, 
	@descX = ProviderSpecialtyDesc, 
	@codeX = ProviderSpecialtyCode
	from NHJAX_ODS.dbo.PROVIDER_SPECIALTY 
	Where ProviderSpecialtyKey = @key
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PROVIDER_SPECIALTY
			(
			ProviderSpecialtyKey,
			ProviderSpecialtyDesc, 
			ProviderSpecialtyCode
			) 
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
			UPDATE NHJAX_ODS.dbo.PROVIDER_SPECIALTY
			SET ProviderSpecialtyDesc = @desc,
			ProviderSpecialtyCode = @code,
			UpdatedDate = GETDATE()
			WHERE ProviderSpecialtyKey = @key;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Provider Specialty Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Provider Specialty Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Provider Specialty Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Provider Specialty',0,@day;
Drop table #Temp
