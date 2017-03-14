CREATE PROCEDURE [dbo].[upENet_SoftwareNameSelect](
	@inactive	bit = 0,
	@sft		int = 0,
	@mfg		int = 0,
	@afn		varchar(100) = '',
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT
			SoftwareId,
			SoftwareDesc,
			Inactive,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			AssetFileName,
			SoftwareManufacturerId
		FROM         
			SOFTWARE_NAME
		WHERE 
			1 = 1 '
IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '
IF @sft > 0
	SELECT @sql = @sql + 'AND SoftwareId = @sft '
IF DataLength(@afn) > 0
	SELECT @sql = @sql + 'AND AssetFileName = @afn '
IF @mfg > 0
	SELECT @sql = @sql + 'AND SoftwareManufacturerId = @mfg '
SELECT @sql = @sql + 'ORDER BY SoftwareDesc '
IF @debug = 1
	PRINT @sql
	PRINT @inactive
SELECT @paramlist = 	'@inactive bit,
			@sft int,
			@mfg int,
			@afn varchar(100) '
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @sft, @mfg, @afn

