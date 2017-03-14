CREATE PROCEDURE [dbo].[upModelSelect](
	@inactive	bit = 0,
	@man		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			MOD.ModelId,
			MOD.ManufacturerId,
			MOD.ModelDesc,
			MAN.ManufacturerDesc,
			MOD.Inactive
		FROM         
			MODEL MOD
			INNER JOIN MANUFACTURER MAN
			ON MOD.ManufacturerId = MAN.ManufacturerId
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND MOD.Inactive = 0 '

IF @man > 0
	SELECT @sql = @sql + 'AND MOD.ManufacturerId = @man '

SELECT @sql = @sql + 'ORDER BY MOD.ModelDesc '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@man int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @man
