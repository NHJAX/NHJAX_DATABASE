CREATE PROCEDURE [dbo].[procENET_Asset_Insert]
(
	@pre varchar(50),
	@num varchar(50),
	@serial varchar(50),
	@mod int,
	@pro int,
	@atyp int,
	@disp int,
	@net varchar(100),
	@bldg int,
	@deck int,
	@aud bigint,
	@room varchar(50),
	@acq datetime,
	@unit money,
	@warr int,
	@bar varchar(20),
	@req varchar(20),
	@lease int,
	@miss bit,
	@loan bit,
	@remote bit,
	@sub int,
	@mac varchar(50),
	@remark varchar(1000),
	@uby int,
	@cby int,
	@desc varchar(100),
	@src int = 0
)
AS

IF DataLength(@serial) > 0
	SET @serial = UPPER(@serial)

INSERT INTO 
    ASSET(PlantAccountPrefix, 
    PlantAccountNumber, 
    SerialNumber, 
    ModelId, 
    ProjectId, 
    AssetTypeId, 
    DispositionId, 
    NetworkName, 
    BuildingId, 
    DeckId, 
    AudienceId, 
    Room, 
    AcquisitionDate, 
    UnitCost, 
    WarrantyMonths, 
    EqpMgtBarCode, 
    ReqDocNumber,
    LeasedPurchased, 
    MissionCritical, 
    OnLoan, 
    RemoteAccess, 
    AssetSubTypeId, 
    MACAddress, 
    Remarks, 
    CreatedBy, 
    UpdatedBy, 
    AssetDesc,
	UpdateSourceSystemId) 
    VALUES(@pre, @num, @serial, @mod, @pro, @atyp, @disp, 
    @net, @bldg, @deck, @aud, @room, @acq, @unit, @warr, 
    @bar, @req, @lease, @miss, @loan, @remote, 
    @sub, @mac, @remark, @cby, @uby, @desc,@src); 
    SELECT AssetId, PlantAccountPrefix, PlantAccountNumber 
    FROM ASSET WHERE AssetId = SCOPE_IDENTITY();


