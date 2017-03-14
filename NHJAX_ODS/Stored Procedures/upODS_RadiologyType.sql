
CREATE PROCEDURE [dbo].[upODS_RadiologyType] AS
Declare @desc varchar(30)
Declare @descX varchar(30)
Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Rad Type',0,@day;
DECLARE curRadType CURSOR FAST_FORWARD FOR
SELECT	DISTINCT TYPE_
FROM	vwMDE_RADIOLOGY_PROCEDURES
WHERE TYPE_ IS NOT NULL
OPEN curRadType
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Rad Type',0
FETCH NEXT FROM curRadType INTO @desc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@descX = RadiologyTypeDesc
		FROM NHJAX_ODS.dbo.RADIOLOGY_TYPE
		WHERE RadiologyTypeDesc = @desc
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.RADIOLOGY_TYPE(
				RadiologyTypeDesc)
				VALUES(@desc);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRadType INTO @desc
	COMMIT
	END

END
CLOSE curRadType
DEALLOCATE curRadType
SET @surow = 'Rad Type Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Rad Type Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Rad Type Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Rad Type',0,@day;
