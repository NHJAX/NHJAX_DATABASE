create PROCEDURE [dbo].[procENET_sessMerge_UpdatePage2]
(
	@sess varchar(100),
	@acq datetime,
	@cost money,
	@warr int,
	@bar varchar(15),
	@req varchar(20),
	@lease int,
	@miss bit,
	@loan bit,
	@remote bit,
	@ip varchar(50),
	@mac varchar(50),
	@hds decimal(19,4),
	@ram decimal(19,4),
	@cpu decimal(19,4),
	@inv datetime,
	@cfg int,
	@share int,
	@dom int
)
AS
	BEGIN TRANSACTION
	
	UPDATE sessMERGE SET 
	AcquisitionDate = @acq,
    UnitCost = @cost,
    WarrantyMonths = @warr,
    EqpMgtBarCode = @bar,
    ReqDocNumber = @req,
    LeasedPurchased = @lease,
    MissionCritical = @miss,
    OnLoan = @loan,
    RemoteAccess = @remote,
    IPAddress = @ip,
    MACAddress = @mac,
    HardDriveSize = @hds,
    RAM = @ram,
    CPUSpeed = @cpu,
    InventoryDate = @inv,
    PrinterConfig = @cfg,
    SharePC = @share,
    DomainId = @dom
    WHERE SessionKey = @sess;
	COMMIT TRANSACTION




