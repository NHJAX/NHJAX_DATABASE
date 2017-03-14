

CREATE PROCEDURE [dbo].[upODS_RadiologyGroup] AS

Declare @rad bigint
Declare @grp bigint

Declare @radX bigint
Declare @grpX bigint

Declare @drow int
Declare @trow int
Declare @irow int
Declare @sdrow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Rad Group',0,@day;

DECLARE curRadGrp CURSOR FAST_FORWARD FOR
SELECT	SGL.RadiologyId AS RadiologyId, 
	GRP.RadiologyId AS RadiologyInGroupId
FROM    RADIOLOGY SGL 
	INNER JOIN vwMDE_RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP RADGRP 
	ON SGL.RadiologyKey = RADGRP.KEY_RADIOLOGY_PROCEDURES 
	INNER JOIN RADIOLOGY GRP 
	ON RADGRP.PROCEDURE_IEN = GRP.RadiologyKey

OPEN curRadGrp
SET @trow = 0
SET @irow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch Rad Group',0

FETCH NEXT FROM curRadGrp INTO @rad,@grp

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@radX = RadiologyId
		FROM NHJAX_ODS.dbo.RADIOLOGY_IN_GROUP
		WHERE 	RadiologyId = @rad
		AND	RadiologyInGroupId = @grp

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.RADIOLOGY_IN_GROUP(
				RadiologyId,RadiologyInGroupId)
				VALUES(@rad,@grp);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRadGrp INTO @rad,@grp
	END
COMMIT
END

CLOSE curRadGrp
DEALLOCATE curRadGrp

--Delete any missing records
EXEC dbo.upActivityLog 'Begin Del Rad Group',0,@day;

DECLARE curDelRadGrp CURSOR FOR
SELECT 	RadiologyId,
	RadiologyInGroupId
	FROM NHJAX_ODS.dbo.RADIOLOGY_IN_GROUP


OPEN curDelRadGrp
EXEC dbo.upActivityLog 'Fetch Del Rad Group',0

FETCH NEXT FROM curDelRadGrp INTO @rad,@grp

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT	@radX = SGL.RadiologyId, 
			@grpX = GRP.RadiologyId
		FROM    RADIOLOGY SGL 
			INNER JOIN vwMDE_RADIOLOGY_PROCEDURES$PROCEDURES_IN_GROUP RADGRP 
			ON SGL.RadiologyKey = RADGRP.KEY_RADIOLOGY_PROCEDURES 
			INNER JOIN RADIOLOGY GRP 
			ON RADGRP.PROCEDURE_IEN = GRP.RadiologyKey
		WHERE 	SGL.RadiologyId = @rad
			AND GRP.RadiologyId = @grp

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				DELETE FROM NHJAX_ODS.dbo.RADIOLOGY_IN_GROUP
				WHERE RadiologyId = @rad
				AND RadiologyInGroupId = @grp;
				SET @drow = @drow + 1
			END
		FETCH NEXT FROM curDelRadGrp INTO @rad,@grp
	END
COMMIT
END

CLOSE curDelRadGrp
DEALLOCATE curDelRadGrp

SET @sdrow = 'Rad Group Deleted: ' + CAST(@drow AS varchar(50))
SET @sirow = 'Rad Group Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Rad Group Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Del Rad Group',0,@day;
EXEC dbo.upActivityLog 'End Rad Group',0,@day;

