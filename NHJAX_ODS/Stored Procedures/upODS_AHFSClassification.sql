

CREATE PROCEDURE [dbo].[upODS_AHFSClassification] AS

Declare @num varchar(53)
Declare @ahfs varchar(110)
Declare @numX varchar(53)
Declare @ahfsX varchar(110)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin AHFS Classification',0,@day

DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		AHFS_NUMBER, 
		AHFS_CLASSIFICATION
	FROM vwMDE_DRUG
	WHERE (AHFS_CLASSIFICATION IS NOT NULL)
	ORDER BY AHFS_CLASSIFICATION
	
OPEN cur
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM cur INTO @num, @ahfs
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @numX = AHFSNumber,
			   @ahfsX = AHFSClassificationDesc
		FROM NHJAX_ODS.dbo.AHFS_CLASSIFICATION
		WHERE AHFSClassificationDesc = @ahfs

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.AHFS_CLASSIFICATION
					(
						AHFSNumber,
						AHFSClassificationDesc
					)
					VALUES(@num,@ahfs);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @num, @ahfs
	COMMIT	
	END
	
END
CLOSE cur
DEALLOCATE cur
SET @sirow = 'AHFS Classification Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'AHFS Classification Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End AHFS Classification',0,@day

