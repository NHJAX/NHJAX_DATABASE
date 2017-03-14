CREATE PROCEDURE [dbo].[msdeAssetSelect]
AS

SELECT
	CAST(0 AS int) AS LocalId,     
	ASSET.AssetId, 
	ASSET.ModelId, 
	CAST(324 AS int) AS ManufacturerId,
	ASSET.PlantAccountPrefix, 
	ASSET.PlantAccountNumber, 
	ASSET.NetworkName, 
	UPPER(ASSET.SerialNumber) AS SerialNumber, 
	ASSET.Remarks, 
	ASSET.EqpMgtBarCode, 
	ASSET.AssetTypeId, 
	ASSET.AssetSubtypeId, 
           	ASSET.DepartmentId, 
	ASSET.BuildingId, 
	CAST(10 AS int) AS BaseId,
	ASSET.DeckId, 
	ASSET.Room, 
	ASSET.UpdatedDate, 
	ASSET.InventoryDate, 
          	ASSET.PrinterConfig, 
	ASSET.SharePC, 
	vwPointOfContact.POCid,
	ASSET.DispositionId,
	0 AS UpdatedBy
FROM	ASSET
	 INNER JOIN vwPointOfContact 
	ON ASSET.AssetId = vwPointOfContact.AssetId
WHERE     
	(ASSET.DispositionId IN(SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1));
