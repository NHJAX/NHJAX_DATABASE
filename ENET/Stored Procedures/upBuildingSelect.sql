CREATE PROCEDURE [dbo].[upBuildingSelect](
	@inactive	bit = 0,
	@bas		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			BLDG.BuildingId,
			BLDG.BaseId,
			BLDG.BuildingDesc,
			BASE.BaseName,
			BLDG.Inactive
		FROM         
			BUILDING BLDG
			INNER JOIN BASE
			ON BLDG.BaseId = Base.BaseId
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND BLDG.Inactive = 0 '

IF @bas > 0
	SELECT @sql = @sql + 'AND BLDG.BaseId = @bas '

SELECT @sql = @sql + 'ORDER BY BLDG.BuildingDesc '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@bas int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @bas
