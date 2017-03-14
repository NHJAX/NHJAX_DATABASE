CREATE PROCEDURE [dbo].[upManufacturerSelect](
	@inactive	bit = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			ManufacturerId,
			ManufacturerDesc,
			Inactive
		FROM         
			MANUFACTURER
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '

SELECT @sql = @sql + 'ORDER BY ManufacturerDesc '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit'
			
EXEC sp_executesql	@sql, @paramlist, @inactive
