
CREATE PROCEDURE [dbo].[upODS_RadiologySingle] AS
Declare @rad decimal
Declare @desc varchar(60)
Declare @code varchar(5)
Declare @type bigint
Declare @unit money

Declare @radX bigint
Declare @descX varchar(60)
Declare @codeX varchar(5)
Declare @typeX bigint
Declare @unitX money

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Radiology',0,@day;

SET @today = getdate()
DECLARE curRad CURSOR FAST_FORWARD FOR
SELECT	RAD.KEY_RADIOLOGY_PROCEDURES, 
	RAD.NAME, 
	RAD.CODE, 
	ISNULL(RADT.RadiologyTypeId, 0) AS RadiologyTypeId,  
        MAX(IsNull(CPT.CMACUnit,0)) AS CMACUnit
FROM   vwMDE_RADIOLOGY_PROCEDURES RAD 
	LEFT OUTER JOIN CPT 
	ON RAD.CPT_CODE_IEN = CPT.CptHcpcsKey 
	LEFT OUTER JOIN RADIOLOGY_TYPE RADT 
	ON RAD.TYPE_ = RADT.RadiologyTypeDesc
GROUP BY RAD.KEY_RADIOLOGY_PROCEDURES, 
	RAD.NAME, 
	RAD.CODE, 
	RADT.RadiologyTypeId

OPEN curRad
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Radiology',0
FETCH NEXT FROM curRad INTO @rad,@desc,@code,@type,@unit
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@radX = RadiologyKey,
			@descX = RadiologyDesc,
			@codeX = RadiologyCode,
			@typeX = RadiologyTypeId,
			@unitX = UnitCost
		FROM NHJAX_ODS.dbo.RADIOLOGY
		WHERE RadiologyKey = @rad
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.RADIOLOGY(
				RadiologyKey,
				RadiologyDesc,
				RadiologyCode,
				RadiologyTypeId,
				UnitCost)
				VALUES(@rad,@desc,@code,@type,@unit);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR 	@code <> @codeX
		OR	@type <> @typeX
		OR	@unit <> @unitX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@code Is Not Null AND @codeX Is Null)
		OR	(@type Is Not Null AND @typeX Is Null)
		OR	(@unit Is Not Null AND @unitX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.RADIOLOGY
			SET 	RadiologyDesc = @desc,
				RadiologyCode = @code,
				RadiologyTypeId = @type,
				UnitCost = @unit,
				UpdatedDate = @today
			WHERE RadiologyKey = @rad;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRad INTO @rad,@desc,@code,@type,@unit
	COMMIT
	END

END
CLOSE curRad
DEALLOCATE curRad
SET @surow = 'Radiology Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Radiology Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Radiology Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Radiology',0,@day;
