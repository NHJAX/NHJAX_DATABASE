CREATE PROCEDURE [dbo].[upsessInvAssetSubTypeSelect]
(
	@tech int
)
AS
SELECT     	AssetSubTypeId 
FROM         	sessINV_ASSET_SUBTYPE
WHERE	CreatedBy = @tech

