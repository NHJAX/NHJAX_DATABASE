create PROCEDURE [dbo].[procENET_sessMerge_Select]
(
	@sess varchar(100)
)
AS
	BEGIN TRANSACTION
	
	SELECT
    SessionKey,
    ModelId,
    ManufacturerId,
    PlantAccountPrefix,
    PlantAccountNumber,
    NetworkName,
    SerialNumber,
    AcquisitionDate,
    MacAddress,
    Remarks,
    AssetDesc,
    WarrantyMonths,
    UnitCost,
    EqpMgtBarCode,
    ReqDocNumber,
    ProjectId,
    AssetTypeId,
    AssetSubTypeId,
    AudienceId,
    BaseId,
    BuildingId,
    DeckId,
    Room,
    MissionCritical,
    RemoteAccess,
    OnLoan,
    LeasedPurchased,
    DispositionId,
    DomainId,
    POCId,
    HardDriveSize,
    RAM,
    CPUSpeed,
    InventoryDate,
    PrinterConfig,
    SharePC
    FROM sessMERGE
    WHERE SessionKey = @sess;
	COMMIT TRANSACTION




