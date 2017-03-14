
CREATE PROCEDURE [dbo].[upODS_Accession_Area] AS

Declare @akey numeric (21,3)
Declare @desc varchar(50)
Declare @type varchar(13)
Declare @abbr varchar (50)

Declare @akeyX numeric (21,3)
Declare @descX varchar(50)
Declare @typeX varchar(13)
Declare @abbrX varchar (50)

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

EXEC dbo.upActivityLog 'Begin Accession_Area',0,@day;

SET @today = getdate()
DECLARE curACCESSION_AREA CURSOR FAST_FORWARD FOR
SELECT AREA.KEY_ACCESSION_AREA,
	   AREA.AREA, 
	   ATYPE.AccessionTypeId, 
       AREA.ABBREVIATION
FROM   vwMDE_ACCESSION_AREA AS AREA 
	INNER JOIN ACCESSION_TYPE AS ATYPE
	ON AREA.LR_SUBSCRIPT = ATYPE.AccessionTypeDesc

OPEN curAccession_Area
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Accession',0

FETCH NEXT FROM curAccession_Area INTO @akey,@desc,@type,@abbr
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@akeyX = AccessionAreaKey,
			@descX = AccessionAreaDesc,
			@typeX = AccessionTypeID,
			@abbrX = AccessionAreaAbbrev
		FROM NHJAX_ODS.dbo.ACCESSION_AREA
		WHERE AccessionAreaKey = @akey
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ACCESSION_AREA
				(
				AccessionAreaKey,
				AccessionAreaDesc,
				AccessionTypeID,
				AccessionAreaAbbrev
				)
				VALUES(@akey,@desc,@type,@abbr);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@akey <> @akeyX
		OR	@desc <> @descX
		OR	@type <> @typeX
		OR	@abbr <> @abbrX
		OR 	(@akey Is Not Null AND @akeyX Is Null)
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@type Is Not Null AND @typeX Is Null)
		OR	(@abbr Is Not Null AND @abbrX Is Null)
		    BEGIN
			UPDATE NHJAX_ODS.dbo.ACCESSION_AREA
			SET 	AccessionAreaKey = @akey,
				AccessionAreaDesc = @desc,
				AccessiontypeID = @type,
				AccessionAreaAbbrev = @abbr
				WHERE AccessionAreaKey = @akey;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAccession_Area INTO @akey,@desc,@type,@abbr
	COMMIT
	END
END
CLOSE curAccession_Area
DEALLOCATE curAccession_Area
SET @surow = 'Accession_Area Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Accession_Area Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Accession_Area Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Accession_Area',0,@day;

