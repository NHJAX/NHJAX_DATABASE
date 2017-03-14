CREATE PROCEDURE [dbo].[upAIM_AssetUpdate]
(
	@aud bigint,
	@bldg int,
	@deck int,
	@room varchar(50),
	@pre	varchar(50),
	@num	varchar(50),
	@mac	varchar(50),
	@mac2 varchar(50) = '',
	@atyp	int,
	@udate datetime,
	@uby int,
	@disp int,
	@dom int,
	@mod int,
	@astyp int,
	@network varchar(100),
	@proj int = 13,
	@acq datetime = '1/1/1900',
	@unit decimal = 0,
	@warr int = 0,
	@req varchar(20) = '',
	@ser varchar(50),
	@ecn varchar(20) = '',
	@debug bit = 0
)
AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

IF DataLength(@ser) > 0
	SET @ser = UPPER(@ser)

SELECT @sql = 'UPDATE ASSET SET
	AudienceId = @aud,
	BuildingId = @Bldg,
	DeckId = @Deck,
	Room = @Room,
	PlantAccountPrefix = @Pre,
	PlantAccountNumber = @Num,
	MacAddress = @Mac,
	AssetTypeId = @ATyp,
	DispositionId = @disp,
	DomainId = @Dom,
	SerialNumber = @ser,
	ModelId = @mod,
	AssetSubTypeId = @astyp, 
	UpdateSourceSystemId = 23, '

IF @proj <> 13
	SELECT @sql = @sql + '	ProjectId = @proj, '

IF @acq <> '1/1/1900'
	SELECT @sql = @sql + '	AcquisitionDate = @acq, '

IF @unit > 0
	SELECT @sql = @sql + '	UnitCost = @unit, '

IF @warr > 0
	SELECT @sql = @sql + '	WarrantyMonths = @warr, '

IF DataLength(@req) > 0
	SELECT @sql = @sql + '	ReqDocNumber = @req, '

IF DataLength(@ecn) > 0
	SELECT @sql = @sql + '	EqpMgtBarCode = @ecn, '

IF DataLength(@mac2) > 0
	SELECT @sql = @sql + 'MacAddress2 = @mac2, '

SELECT @sql = @sql + 'UpdatedDate = @UDate,
	UpdatedBy = @UBy
WHERE DispositionId IN(SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1)
	AND NetworkName = @network '

IF @debug = 1
	PRINT @sql
	PRINT @network
	PRINT @mac
	PRINT @mac2
	

SELECT @paramlist = 	'@aud bigint,
			@bldg int,
			@deck int,
			@room varchar(50),
			@pre	varchar(50),
			@num	varchar(50),
			@mac	varchar(50),
			@mac2 varchar(50),
			@atyp	int,
			@udate datetime,
			@uby int,
			@disp int,
			@dom int,
			@ser varchar(50),
			@mod int,
			@astyp int,
			@network varchar(100),
			@proj int,
			@acq datetime,
			@unit decimal,
			@warr int,
			@req varchar(20), 
			@ecn varchar(15) '

EXEC sp_executesql	@sql, @paramlist, @aud,@bldg,@deck,@room,@pre,@num,@mac,@mac2,@atyp,@udate,@uby,
			@disp,@dom,@ser,@mod,@astyp,@network,@proj,@acq,@unit,@warr,@req,@ecn
