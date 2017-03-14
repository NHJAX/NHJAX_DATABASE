CREATE PROCEDURE [dbo].[upBaseSelect](
	@inactive	bit = 0,
	@base		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			BaseId,
			BaseName,
			SortOrder,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive,
			BaseCode
		FROM         
			BASE
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '

IF @base > 0
	SELECT @sql = @sql + 'AND BaseId = @base '

SELECT @sql = @sql + 'ORDER BY SortOrder '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@base int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @base
