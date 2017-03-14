CREATE VIEW [dbo].[vwAssetPrinters]
AS
SELECT     AssetPrinterId, AssetId, PrinterId, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, Inactive
FROM         dbo.ASSET_PRINTER

