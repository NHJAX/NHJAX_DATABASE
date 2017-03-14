CREATE VIEW [dbo].[vwSIM_MaxUpdateExtension]
AS
SELECT     dbo.vwSIM_AssetFileExtensionProduct.AssetId, dbo.vwSIM_AssetFileExtensionProduct.AssetFileExtensionId, 
                      ISNULL(MAX(dbo.ASSET_FILE.UpdatedDate), '1/1/1900') AS MaxDate
FROM         dbo.ASSET_FILE RIGHT OUTER JOIN
                      dbo.vwSIM_AssetFileExtensionProduct ON dbo.ASSET_FILE.AssetId = dbo.vwSIM_AssetFileExtensionProduct.AssetId AND 
                      dbo.ASSET_FILE.AssetFileExtensionId = dbo.vwSIM_AssetFileExtensionProduct.AssetFileExtensionId
GROUP BY dbo.vwSIM_AssetFileExtensionProduct.AssetFileExtensionId, dbo.vwSIM_AssetFileExtensionProduct.AssetId

