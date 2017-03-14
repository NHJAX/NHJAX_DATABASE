CREATE VIEW [dbo].[vwAssetsLessThan1000CPU_Tommy_20051206]
AS
SELECT     dbo.MANUFACTURER.ManufacturerId, COUNT(dbo.MANUFACTURER.ManufacturerId) AS Countofmanufacturer
FROM         dbo.ASSET INNER JOIN
                      dbo.ASSET_COMPUTER ON dbo.ASSET.AssetId = dbo.ASSET_COMPUTER.AssetId INNER JOIN
                      dbo.MODEL ON dbo.ASSET.ModelId = dbo.MODEL.ModelId INNER JOIN
                      dbo.MANUFACTURER ON dbo.MODEL.ManufacturerId = dbo.MANUFACTURER.ManufacturerId
WHERE     (dbo.ASSET.AssetTypeId = 1) AND (dbo.ASSET_COMPUTER.CPUSpeed < 1000) AND (dbo.ASSET_COMPUTER.CPUSpeed > 0) AND 
                      (dbo.ASSET.DispositionId IN (0, 1))
GROUP BY dbo.MANUFACTURER.ManufacturerId

