CREATE PROCEDURE [dbo].[upAssetTypeSelect](
	@inactive	bit = 0,
	@atyp		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			AssetTypeId,
			AssetTypeDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			ASSET_TYPE
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '

IF @atyp > 0
	SELECT @sql = @sql + 'AND AssetTypeId = @atyp '

SELECT @sql = @sql + 'ORDER BY AssetTypeDesc '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@atyp int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @atyp
