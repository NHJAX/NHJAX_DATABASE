

CREATE PROCEDURE [dbo].[upENET_ASSET_OVERRIDE_BulkRefreshALTHA] 
 
AS
DECLARE @ast int
DECLARE @astx int
DECLARE @asty int
Declare @exists int

DECLARE dCursor cursor FOR 
SELECT     AssetId
FROM       ASSET_FILE
WHERE     (AssetFileName = 'cw.exe')

OPEN dCursor

/* get first record */
FETCH NEXT FROM dCursor INTO @ast
if(@@FETCH_STATUS = 0)
	BEGIN
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
		BEGIN TRANSACTION
		Select @astX = AssetId
		from ASSET_FILE_OVERRIDE 
		Where AssetId = @ast
		AND AssetFileExtensionId = 1
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN

				/* insert record into ASSET_FILE_OVERRRIDE */
				INSERT INTO ASSET_FILE_OVERRIDE
				(
				AssetId,
				AssetFileExtensionId,
				AuditOverride
				)
				VALUES
				(
				@ast, 
				1, 
				1
				)
			END

		/*secondary insert for asset_file_search */
		Select @astY = AssetId
		from ASSET_FILE_SEARCH 
		Where AssetId = @ast
		SET @exists = @@RowCount
		If @exists = 0
			BEGIN

				/* insert record into ASSET_FILE_OVERRRIDE */
				INSERT INTO ASSET_FILE_SEARCH
				(
				AssetId,
				SearchAll,
				IncludeDefaults,
				RunAudit
				)
				VALUES
				(
				@ast, 
				0, 
				0,
				1
				)

			END

			
		/* get next record */
		FETCH NEXT FROM dCursor INTO @ast
		COMMIT
	END
	
	
END
CLOSE dCURSOR
DEALLOCATE dCURSOR
