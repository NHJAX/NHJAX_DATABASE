CREATE PROCEDURE [dbo].[upAIM_AssetInsert]
(
	@network varchar(100), 
	@aud bigint, 	
	@bldg int, 
	@deck int, 
	@room varchar(50), 
	@pre varchar(50), 
	@num varchar(50), 
	@mac varchar(50), 
	@mac2 varchar(50) = '',
	@udate datetime, 
	@atyp int, 
	@uby int, 
	@cby int, 
	@disp int, 
	@dom int,
	@ser varchar(50), 
	@mod int,
	@astyp int,
	@proj int = 13,
	@acq datetime = '01/01/1900',
	@unit decimal = 0,
	@warr int = 0,
	@req varchar(20) = '',
	@ecn varchar(20) = '',
	@debug bit = 0
)
AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

IF DataLength(@ser) > 0
	SET @ser = UPPER(@ser)

SELECT @sql = 'INSERT INTO ASSET 
(
	NetworkName, 
	AudienceId, 
	BuildingId,
	DeckId, 
	Room, 
	PlantAccountPrefix, 
	PlantAccountNumber,
	MacAddress, '

IF DataLength(@mac2) > 0
	SELECT @sql = @sql + 'MacAddress2, '

SELECT @sql = @sql + '	UpdatedDate, 
	AssetTypeId,
	UpdatedBy, 
	CreatedBy, 
	DispositionId, 
	DomainId, 
	SerialNumber, 
	ModelId,
	AssetSubTypeId,
	ProjectId,
	AcquisitionDate,
	UnitCost,
	WarrantyMonths,
	ReqDocNumber,
	EqpMgtBarCode,
	UpdateSourceSystemId
) 
	VALUES
(
	@network, 
	@aud, 	
	@bldg, 
	@deck, 
	@room, 
	@pre, 
	@num, 
	@mac, '

IF DataLength(@mac2) > 0
	SELECT @sql = @sql + '@mac2, '

SELECT @sql = @sql + '	@udate, 
	@atyp, 
	@uby, 
	@cby, 
	@disp, 
	@dom,
	@ser, 
	@mod,
	@astyp,
	@proj,
	@acq,
	@unit,
	@warr,
	@req,
	@ecn,
	23)
	;SELECT SCOPE_IDENTITY() '

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
			@cby int,
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

EXEC sp_executesql	@sql, @paramlist, @aud,@bldg,@deck,@room,@pre,@num,@mac,@mac2,@atyp,@udate,@uby,@cby,
			@disp,@dom,@ser,@mod,@astyp,@network,@proj,@acq,@unit,@warr,@req,@ecn
