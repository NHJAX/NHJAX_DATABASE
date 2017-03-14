CREATE PROCEDURE [dbo].[upENet_SoftwareLicenseUpdate]
(
	@lic		int,
	@desc		varchar(1000),
	@ver		varchar(30),
	@upg		int,
	@pur		datetime,
	@cost		decimal,
	@dsk		int,
	@reg		varchar(50) = '',
	@key		varchar(50) = '',
	@loc		int,
	@oth		varchar(50) = '',
	@udate		datetime,
	@uby		int,
	@vnd		int,
	@req		varchar(50) = '',
	@po		varchar(50) = '',
	@usr		int,
	@inactive	bit,
	@exp		datetime,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'UPDATE SOFTWARE_LICENSE SET
			SoftwareLicenseDesc = @desc,
			SoftwareVersion = @ver,
			Upgrade = @upg,
			PurchaseDate = @pur,
			Cost = @cost,
			NumberofDisks = @dsk, '
IF DataLength(@reg) > 0
	SELECT @sql = @sql + 'SoftwareRegistration = @reg, '
IF DataLength(@key) > 0
	SELECT @sql = @sql + 'CDKey = @key, '
SELECT @sql = @sql + '	SoftwareLocationId = @loc, '
IF DataLength(@oth) > 0
	SELECT @sql = @sql + 'OtherLocation = @oth, '
SELECT @sql = @sql + 'UpdatedBy = @uby,
			UpdatedDate = @udate,
			SoftwareVendorId = @vnd, '
IF DataLength(@req) > 0
	SELECT @sql = @sql + 'RequisitionNumber = @req, '
IF DataLength(@po) > 0
	SELECT @sql = @sql + 'PurchaseOrder = @po, '
SELECT @sql = @sql + '	NumberofUsers = @usr,
			Inactive = @inactive,
			ExpirationDate = @exp
			WHERE SoftwareLicenseId = @lic '
IF @debug = 1
	PRINT @sql
	
SELECT @paramlist = 	'@lic		int,
			@desc		varchar(1000),
			@ver		varchar(20),
			@upg		int,
			@pur		datetime,
			@cost		decimal,
			@dsk		int,
			@reg		varchar(50),
			@key		varchar(50),
			@loc		int,
			@oth		varchar(50),
			@udate		datetime,
			@uby		int,
			@vnd		int,
			@req		varchar(50),
			@po		varchar(50),
			@usr		int,
			@inactive	bit,
			@exp		datetime '
EXEC sp_executesql	@sql, @paramlist, @lic, @desc, @ver,@upg,@pur,@cost,@dsk,@reg,@key,@loc,@oth,@udate,
				@uby,@vnd,@req,@po,@usr,@inactive,@exp

