CREATE VIEW [dbo].[vwSIM_AssetFileExtensionProduct]
AS
SELECT     dbo.ASSET.AssetId, dbo.ASSET_FILE_EXTENSION.AssetFileExtensionId
FROM         dbo.ASSET CROSS JOIN
                      dbo.ASSET_FILE_EXTENSION
WHERE     (dbo.ASSET.DispositionId IN (1, 2, 9, 14)) AND (dbo.ASSET.AssetTypeId = 1)

