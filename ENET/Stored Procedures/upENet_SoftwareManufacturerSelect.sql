CREATE PROCEDURE [dbo].[upENet_SoftwareManufacturerSelect](
	@inactive	bit = 0,
	@desc		varchar(50) = '',
	@mfr		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT
			SoftwareManufacturerId,
			SoftwareManufacturerDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			SOFTWARE_MANUFACTURER
		WHERE 
			1 = 1 '
IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '
IF @mfr > 0
	SELECT @sql = @sql + 'AND SoftwareManufacturerId = @mfr '
IF DataLength(@desc) > 0
	SELECT @sql = @sql + 'AND SoftwareManufacturerDesc = @desc '

SELECT @sql = @sql + 'ORDER BY SoftwareManufacturerDesc '
IF @debug = 1
	PRINT @sql
	PRINT @inactive
SELECT @paramlist = 	'@inactive bit,
			@desc varchar(50),
			@mfr int '
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @desc, @mfr
