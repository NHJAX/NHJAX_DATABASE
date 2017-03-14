

CREATE PROCEDURE [dbo].[upODS_TherapeuticClass] AS

Declare @tc varchar(108)
Declare @tcX varchar(110)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Therapeutic Class',0,@day

DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		THERAPEUTIC_CLASS
	FROM vwMDE_DRUG
	WHERE (THERAPEUTIC_CLASS IS NOT NULL)
	ORDER BY THERAPEUTIC_CLASS
	
OPEN cur
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM cur INTO @tc
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @tcX = TherapeuticClassDesc
		FROM NHJAX_ODS.dbo.THERAPEUTIC_CLASS
		WHERE TherapeuticClassDesc = @tc

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.THERAPEUTIC_CLASS
					(
						TherapeuticClassDesc
					)
					VALUES(@tc);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @tc
	COMMIT	
	END
	
END
CLOSE cur
DEALLOCATE cur
SET @sirow = 'Therapeutic Class Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Therapeutic Class Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Therapeutic Class',0,@day

