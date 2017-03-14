CREATE PROCEDURE [dbo].[upAssetSubTypeSelect](
	@inactive	bit = 0,
	@atyp		int = 0,
	@astyp		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			ASTYP.AssetSubTypeId,
			ASTYP.AssetSubTypeDesc,
			ASTYP.AssetTypeId,
			ATYP.AssetTypeDesc,
			ASTYP.CreatedDate,
			ASTYP.CreatedBy,
			ASTYP.UpdatedDate,
			ASTYP.UpdatedBy,
			ASTYP.Inactive,
			RTRIM(TECH.UFName) AS UFName, 
			RTRIM(TECH.ULName) AS ULName,
			RTRIM(TECH.UMName) AS UMName
		FROM         
			ASSET_SUBTYPE ASTYP
			INNER JOIN ASSET_TYPE ATYP
			ON ASTYP.AssetTypeId = ATYP.AssetTypeId
			INNER JOIN TECHNICIAN TECH
			ON ASTYP.UpdatedBy = TECH.UserId
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND ASTYP.Inactive = 0 '

IF @atyp > 0
	SELECT @sql = @sql + 'AND ASTYP.AssetTypeId = @atyp '

IF @astyp > 0
	SELECT @sql = @sql + 'AND ASTYP.AssetSubTypeId = @astyp '

SELECT @sql = @sql + 'ORDER BY ASTYP.AssetSubTypeDesc '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@atyp int,
			@astyp int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @atyp, @astyp
