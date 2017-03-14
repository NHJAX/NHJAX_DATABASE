CREATE VIEW [dbo].[vwAssetIps]
AS
SELECT     AssetIPId, AssetId, IPAddress, CreatedDate, CreatedBy
FROM         dbo.ASSET_IP

