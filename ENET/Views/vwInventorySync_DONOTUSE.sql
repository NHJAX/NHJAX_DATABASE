CREATE VIEW [dbo].[vwInventorySync_DONOTUSE]
AS
SELECT     dbo.ASSET.AssetId, dbo.ASSET.ModelId, dbo.ASSET.PlantAccountPrefix, dbo.ASSET.PlantAccountNumber, dbo.ASSET.NetworkName, 
                      dbo.ASSET.SerialNumber, dbo.ASSET.Remarks, dbo.ASSET.EqpMgtBarCode, dbo.ASSET.AssetTypeId, dbo.ASSET.AssetSubtypeId, 
                      dbo.ASSET.DepartmentId, dbo.ASSET.BuildingId, dbo.ASSET.DeckId, dbo.ASSET.Room, dbo.ASSET.UpdatedDate, dbo.ASSET.InventoryDate, 
                      dbo.ASSET.PrinterConfig, dbo.ASSET.SharePC, dbo.vwPointOfContact.POCid
FROM         dbo.ASSET INNER JOIN
                      dbo.vwPointOfContact ON dbo.ASSET.AssetId = dbo.vwPointOfContact.AssetId
WHERE     (dbo.ASSET.DispositionId < 2)

