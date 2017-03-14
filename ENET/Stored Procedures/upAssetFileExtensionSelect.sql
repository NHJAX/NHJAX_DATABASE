CREATE PROCEDURE [dbo].[upAssetFileExtensionSelect](
	@inactive	bit = 0,
	@ext		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT
			AssetFileExtensionId,
			AssetFileExtensionDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			ASSET_FILE_EXTENSION
		WHERE 
			1 = 1 '
IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '
IF @ext > 0
	SELECT @sql = @sql + 'AND AssetFileExtensionId = @ext '
SELECT @sql = @sql + 'ORDER BY AssetFileExtensionDesc '
IF @debug = 1
	PRINT @sql
	PRINT @inactive
SELECT @paramlist = 	'@inactive bit,
			@ext int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @ext

