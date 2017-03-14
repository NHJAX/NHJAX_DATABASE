CREATE PROCEDURE [dbo].[upENet_SoftwareVendorSelect](
	@inactive	bit = 0,
	@vnd		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT
			SoftwareVendorId,
			SoftwareVendorDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			SOFTWARE_VENDOR
		WHERE 
			1 = 1 '
IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '
IF @vnd > 0
	SELECT @sql = @sql + 'AND SoftwareVendorId = @vnd '
SELECT @sql = @sql + 'ORDER BY SoftwareVendorDesc '
IF @debug = 1
	PRINT @sql
	PRINT @inactive
SELECT @paramlist = 	'@inactive bit,
			@vnd int '
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @vnd

