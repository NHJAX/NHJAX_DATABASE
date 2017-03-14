CREATE VIEW [dbo].[vwAssetComputers]
AS
SELECT     AssetId, RAMSize, HardDriveSize, CPUSpeed, CreatedDate, UpdatedDate
FROM         dbo.ASSET_COMPUTER

