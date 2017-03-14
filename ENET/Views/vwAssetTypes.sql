CREATE VIEW [dbo].[vwAssetTypes]
AS
SELECT     AssetTypeId, AssetTypeDesc, CreatedBy, CreatedDate, UpdatedDate, UpdatedBy, Inactive
FROM         dbo.ASSET_TYPE

