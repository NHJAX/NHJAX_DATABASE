CREATE PROCEDURE [dbo].[upCE_AssetUpdate]
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
	@InventoryDate datetime,
	@AssetId int
)
AS

UPDATE Asset SET PlantAccountPrefix=@Prefix, PlantAccountNumber=@Number, SerialNumber=@Serial, EqpMgtBarcode=@BarCode, BuildingId=@Building, DeckId=@Deck, Room=@Room, DepartmentId=@Dept, ModelId=@Model, AssetTypeId=@Type, AssetSubtypeId=@SubType, PrinterConfig=@Config, AcquisitionDate=@Acquisition, WarrantyMonths=@Warranty, UnitCost=@Cost, ProjectId=@Project, NetworkName=@Network, Remarks=@Remarks, UpdatedBy=4129, UpdatedDate=@UpdatedDate, InventoryDate=@InventoryDate WHERE AssetId=@AssetId
