CREATE PROCEDURE [dbo].[upENet_SoftwareLocationSelect](
	@inactive	bit = 0,
	@loc		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT
			SoftwareLocationId,
			SoftwareLocationDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			SOFTWARE_LOCATION
		WHERE 
			1 = 1 '
IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '
IF @loc > 0
	SELECT @sql = @sql + 'AND SoftwareLocationId = @loc '
SELECT @sql = @sql + 'ORDER BY SoftwareLocationDesc '
IF @debug = 1
	PRINT @sql
	PRINT @inactive
SELECT @paramlist = 	'@inactive bit,
			@loc int '
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @loc

