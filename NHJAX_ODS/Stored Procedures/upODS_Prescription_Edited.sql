
CREATE PROCEDURE [dbo].[upODS_Prescription_Edited] AS

Declare @edit varchar(30)

Declare @editX varchar(30)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Presciption Edited',0,@day;


DECLARE curEdit CURSOR FAST_FORWARD FOR
SELECT	DISTINCT EDITED
	
FROM	vwMDE_PRESCRIPTION

WHERE DataLength(EDITED) > 0

OPEN cureDIT
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Presciption Edited',0

FETCH NEXT FROM curEdit INTO @edit

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@editX = EditedDesc		
		FROM NHJAX_ODS.dbo.PRESCRIPTION_EDITED
		WHERE EditedDesc = @edit

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_EDITED(
				EditedDesc)
				VALUES(@edit);
				SET @irow = @irow + 1
			END
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curEdit INTO @edit
	COMMIT
	END

END


CLOSE curEdit
DEALLOCATE curEdit

SET @sirow = 'Presciption Edited Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Presciption Edited Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Presciption Edited',0,@day;
