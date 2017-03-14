
CREATE PROCEDURE [dbo].[upODS_RadiologyPanel] AS

Declare @rad decimal
Declare @desc varchar(30)
Declare @group bigint
Declare @unit numeric(15,2)
Declare @cnt bigint

Declare @radX decimal
Declare @descX varchar(30)
Declare @groupX bigint
Declare @unitX numeric(15,2)

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

EXEC dbo.upActivityLog 'Begin Radiology(2)',0,@day;

SET @today = getdate()

DECLARE curRad CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	RAD.KEY_RADIOLOGY_PROCEDURES, 
	RAD.NAME, 
	RADT.RadiologyTypeId, 
	SUM(ISNULL(RT2.UnitCost, 0)) AS UnitCost, 
	COUNT(RT1.RadiologyId)AS CountofGroup
FROM    RADIOLOGY RT1 
	INNER JOIN vwMDE_RADIOLOGY_PROCEDURES RAD 
	INNER JOIN RADIOLOGY_TYPE RADT 
	ON RAD.TYPE_ = RADT.RadiologyTypeDesc 
	ON RT1.RadiologyKey = RAD.KEY_RADIOLOGY_PROCEDURES 
	INNER JOIN RADIOLOGY_IN_GROUP RADGRP 
	ON RT1.RadiologyId = RADGRP.RadiologyId 
	INNER JOIN RADIOLOGY RT2 
	ON RADGRP.RadiologyInGroupId = RT2.RadiologyId
GROUP BY RAD.NAME, RADT.RadiologyTypeId, RAD.KEY_RADIOLOGY_PROCEDURES
HAVING  (RADT.RadiologyTypeId = 1)

OPEN curRad
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Radiology(2)',0

FETCH NEXT FROM curRad INTO @rad,@desc,@group,@unit,@cnt

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@radX = RadiologyKey,
			@descX = RadiologyDesc,
			@groupX = RadiologyTypeId,
			@unitX = UnitCost
		FROM NHJAX_ODS.dbo.RADIOLOGY
		WHERE RadiologyKey = @rad

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.RADIOLOGY(
				RadiologyKey,
				RadiologyDesc,
				RadiologyTypeId,
				UnitCost)
				VALUES(@rad,@desc,@group,@unit);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR 	@group <> @groupX
		OR	@unit <> @unitX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@group Is Not Null AND @groupX Is Null)
		OR	(@unit Is Not Null AND @unitX Is Null)

			BEGIN
			UPDATE NHJAX_ODS.dbo.RADIOLOGY
			SET 	RadiologyDesc = @desc,
				RadiologyTypeId = @group,
				UnitCost = @unit,
				UpdatedDate = @today
			WHERE RadiologyKey = @rad;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRad INTO @rad,@desc,@group,@unit,@cnt
	COMMIT
	END

END


CLOSE curRad
DEALLOCATE curRad

SET @surow = 'Radiology Updated(2): ' + CAST(@urow AS varchar(50))
SET @sirow = 'Radiology Inserted(2): ' + CAST(@irow AS varchar(50))
SET @strow = 'Radiology Total(2): ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Radiology(2)',0,@day;
