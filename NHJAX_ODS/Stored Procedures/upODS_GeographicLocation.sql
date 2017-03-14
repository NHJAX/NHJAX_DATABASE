
CREATE PROCEDURE [dbo].[upODS_GeographicLocation] AS
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
Declare @geokey decimal
Declare @geoname varchar(50)
Declare @geoabbv varchar(5)
Declare @geokeyX decimal
Declare @geonameX varchar(50)
Declare @geoabbvX varchar(5)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Geographic Location',0,@day;
Select Identity(int,1,1) ID,
	KEY_GEOGRAPHIC_LOCATION, 
	NAME, 
	ABBREVIATION
	into #Temp 
	FROM vwMDE_GEOGRAPHIC_LOCATION
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @geokey = KEY_GEOGRAPHIC_LOCATION, 
	@geoname = NAME, 
	@geoabbv = ABBREVIATION
	from #Temp 
	Where ID = @trow
		
	Select @geokeyX = GeographicLocationKey, 
	@geonameX = GeographicLocationDesc, 
	@geoabbvX = GeographicLocationAbbrev
	from NHJAX_ODS.dbo.GEOGRAPHIC_LOCATION 
	Where GeographicLocationKey = @geokey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.GEOGRAPHIC_LOCATION(GeographicLocationKey,
			GeographicLocationDesc, 
			GeographicLocationAbbrev) 
		VALUES(@geokey, 
			@geoname, 
			@geoabbv);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @geoname <> @geonameX
		OR @geoabbv <> @geoabbvX
		OR (@geoname Is Not Null AND @geonameX Is Null)
		OR (@geoabbv Is Not Null AND @geoabbvX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.GEOGRAPHIC_LOCATION
			SET GeographicLocationDesc = @geoname,
			GeographicLocationAbbrev = @geoabbv,
			UpdatedDate = @today
			WHERE GeographicLocationKey = @geokey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Geo Loc Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Geo Loc Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Geo Loc Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Geographic Location',0,@day;
Drop table #Temp
