CREATE PROCEDURE [dbo].[upCE_AssetInsert]
(
	@Prefix varchar(50),
	@Number varchar(50),
	@Serial varchar(50),
	@BarCode varchar(15),
	@Building int,
	@Deck int,
	@Room varchar(50),
	@Dept int,
	@Model int,
	@Type int,
	@SubType int,
	@Config int,
	@Acquisition datetime,
	@Warranty int,
	@Cost money,
	@Project int,	
	@Network varchar(100),
	@Remarks varchar(1000),
	@UpdatedDate datetime,
	@InventoryDate datetime
)
AS

INSERT INTO Asset (PlantAccountPrefix, PlantAccountNumber, SerialNumber, EqpMgtBarCode, BuildingId, DeckId, Room, DepartmentId, ModelId, AssetTypeId, AssetSubtypeId, PrinterConfig, AcquisitionDate, WarrantyMonths, UnitCost, ProjectId, NetworkName, Remarks, MissionCritical, RemoteAccess, OnLoan, LeasedPurchased, DispositionId, DomainId, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, InventoryDate) VALUES(@Prefix, @Number, @Serial, @BarCode, @Building, @Deck, @Room, @Dept, @Model, @Type, @SubType, @Config, @Acquisition, @Warranty, @Cost, @Project, @Network, @Remarks, 1, 1, 0, 1, 1, 0, 4129, @UpdatedDate, 4129, @UpdatedDate, @InventoryDate)
