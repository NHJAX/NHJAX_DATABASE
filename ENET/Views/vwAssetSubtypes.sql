CREATE VIEW [dbo].[vwAssetSubtypes]
AS
SELECT     AssetSubTypeId, AssetSubTypeDesc, AssetTypeId, CreatedDate, CreatedBy, UpdatedDate, UpdatedBy, Inactive
FROM         dbo.ASSET_SUBTYPE

