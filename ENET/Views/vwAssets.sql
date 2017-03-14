CREATE VIEW [dbo].[vwAssets]
AS
SELECT     AssetId, ModelId, PlantAccountPrefix, PlantAccountNumber, NetworkName, SerialNumber, AcquisitionDate, MacAddress, Remarks, AssetDesc, 
                      WarrantyMonths, UnitCost, EqpMgtBarCode, ReqDocNumber, ProjectId, AssetTypeId, AssetSubtypeId, DepartmentId, BuildingId, DeckId, Room, 
                      MissionCritical, RemoteAccess, OnLoan, LeasedPurchased, DispositionId, DomainId, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate
FROM         dbo.ASSET



