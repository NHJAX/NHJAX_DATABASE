
CREATE PROCEDURE [dbo].[upODS_AccessToCare]  AS



Declare @atc bigint
Declare @key numeric(7,3)
Declare @desc varchar(30)
Declare @std numeric(10,3)

Declare @atcX bigint
Declare @keyX numeric(7,3)
Declare @descX varchar(30)
Declare @stdX numeric(10,3)

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

EXEC dbo.upActivityLog 'Begin Atc',0,@day;

SET @today = getdate()
DECLARE curAtc CURSOR FAST_FORWARD FOR
SELECT	KEY_ACCESS_TO_CARE_CATEGORY, 
	NAME, 
	STANDARD
FROM    vwMDE_ACCESS_TO_CARE_CATEGORY
ORDER BY KEY_ACCESS_TO_CARE_CATEGORY

OPEN curAtc
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Atc',0

FETCH NEXT FROM curAtc INTO @key,@desc,@std
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@keyX = AccessToCareKey,
			@descX = AccessToCareDesc,
			@stdX = AccessToCareStandard
		FROM NHJAX_ODS.dbo.ACCESS_TO_CARE
		WHERE AccessToCareKey = @key
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ACCESS_TO_CARE(
				AccessToCareKey,
				AccessToCareDesc,
				AccessToCareStandard)
				VALUES(@key,@desc,@std);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@std <> @stdX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@std Is Not Null AND @stdX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ACCESS_TO_CARE
			SET 	AccessToCareDesc = @desc,
				AccessToCareStandard = @std,
				UpdatedDate = @today
			WHERE AccessToCareKey = @key;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAtc INTO @key,@desc,@std
	COMMIT
	END
END
CLOSE curAtc
DEALLOCATE curAtc
SET @surow = 'Atc Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Atc Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Atc Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Atc',0,@day;
