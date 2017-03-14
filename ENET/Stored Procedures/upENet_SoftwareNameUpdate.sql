CREATE PROCEDURE [dbo].[upENet_SoftwareNameUpdate]
(
	@sft		int,
	@desc		varchar(50),
	@afn		varchar(100) = '',
	@mfr		int = 0,
	@inactive	bit = 0,
	@udate		datetime,
	@uby		int,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'UPDATE SOFTWARE_NAME SET
			SoftwareDesc = @desc,
			UpdatedDate = @udate,
			Inactive = @inactive, '
IF DataLength(@afn) > 0
	SELECT @sql = @sql + 'AssetFileName = @afn, '
IF @mfr > 0 
	SELECT @sql = @sql + 'SoftwareManufacturerId = @mfr, '
SELECT @sql = @sql + '	UpdatedBy = @uby
			WHERE SoftwareId = @sft '
IF @debug = 1
	PRINT @sql
	
SELECT @paramlist = 	'@sft		int,
			@desc		varchar(50),
			@inactive	bit,
			@uby		int,
			@udate		datetime,
			@afn		varchar(100),
			@mfr		int '
EXEC sp_executesql	@sql, @paramlist, @sft, @desc, @inactive, @uby, @udate, @afn, @mfr

