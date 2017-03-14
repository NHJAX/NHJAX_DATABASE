CREATE PROCEDURE [dbo].[msdeAssetUpdate]
(
	@ast		int,
	@pre		varchar(50),
	@num		varchar(50),
	@ser		varchar(50),
	@mod		int,
	@atyp		int,
	@bldg		int = 0,
	@deck		int = 0,
	@dept		int = 0,
	@room		varchar(50),
	@bar		varchar(50) = '',
	@astyp		bigint = 0,
	@rem		varchar(1000) = '',
	@udate		datetime,
	@idate		datetime,
	@config	int,
	@share		int,
	@uby		int,
	@disp		int,
	@net		varchar(100) = '',
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

IF DataLength(@ser) > 0
	SET @ser = UPPER(@ser)

SELECT @sql = 'UPDATE ASSET SET
			PlantAccountPrefix = @pre,
			PlantAccountNumber = @num,
			SerialNumber = @ser,
			ModelId = @mod,
			AssetTypeId = @atyp,
			BuildingId = @bldg,
			DeckId = @deck,
			Room = @room,
			UpdatedDate = @udate,
			InventoryDate = @idate,
			PrinterConfig = @config,
			SharePC = @share, 
			DispositionId = @disp,
			UpdateSourceSystemId = 24, '
IF @dept > 0
	SELECT @sql = @sql + 'AudienceId = @dept, '

IF @astyp > 0 
	SELECT @sql = @sql + 'AssetSubTypeId = @astyp, '

IF DataLength(@net) > 0
	SELECT @sql = @sql + 'NetworkName = @net, '

IF DataLength(@rem) > 0
	SELECT @sql = @sql + '	Remarks = @rem, '

IF DataLength(@bar) > 0
	SELECT @sql = @sql + 'EqpMgtBarCode = @bar, '

SELECT @sql = @sql + '	UpdatedBy = @uby
			WHERE AssetId = @ast '

IF @debug = 1
	PRINT @sql
	PRINT @num
	PRINT @ser
	PRINT @bar
	PRINT @rem
	PRINT @net
	PRINT @dept
SELECT @paramlist = 	'@ast		int,
			@pre		varchar(50),
			@num		varchar(50),
			@ser		varchar(50),
			@mod		int,
			@atyp		int,
			@bldg		int,
			@deck		int,
			@dept		int,
			@room		varchar(50),
			@bar		varchar(50),
			@astyp		int,
			@rem		varchar(1000),
			@udate		datetime,
			@idate		datetime,
			@config	int,
			@share		int,
			@uby		int,
			@disp		int,
			@net	 	varchar(100)'
EXEC sp_executesql	@sql, @paramlist, @ast, @pre, @num, @ser, @mod, @atyp, @bldg, 
			@deck, @dept, @room, @bar, @astyp, @rem, @udate, @idate, @config, 
			@share, @uby, @disp, @net
