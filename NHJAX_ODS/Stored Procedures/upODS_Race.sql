
CREATE PROCEDURE [dbo].[upODS_Race] AS

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

Declare @racekey numeric(7,3)
Declare @racedesc varchar(32)
Declare @racecode varchar(1)

Declare @racekeyX numeric(7,3)
Declare @racedescX varchar(32)
Declare @racecodeX varchar(1)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Race',0,@day;

Select Identity(int,1,1) ID,
	KEY_RACE, 
	DESCRIPTION, 
	CODE
	into #Temp 
	FROM vwMDE_RACE

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @racekey = KEY_RACE, 
	@racedesc = DESCRIPTION, 
	@racecode = CODE
	from #Temp 
	Where ID = @trow
		
	Select @racekeyX = RaceKey, 
	@racedescX = RaceDesc, 
	@racecodeX = RaceCode
	from NHJAX_ODS.dbo.RACE 
	Where RaceKey = @racekey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.RACE(RaceKey,
			RaceDesc, 
			RaceCode) 
		VALUES(@racekey, 
			@racedesc, 
			@racecode);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @racedesc <> @racedescX
		OR @racecode <> @racecodeX
		OR (@racedesc Is Not Null AND @racedescX Is Null)
		OR (@racecode Is Not Null AND @racecodeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.RACE
			SET RaceDesc = @racedesc,
			RaceCode = @racecode,
			UpdatedDate = @today
			WHERE RaceKey = @racekey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Race Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Race Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Race Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Race',0,@day;
Drop table #Temp
