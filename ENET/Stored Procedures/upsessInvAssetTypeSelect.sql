CREATE PROCEDURE [dbo].[upsessInvAssetTypeSelect]
(
	@tech int
)
AS
SELECT     	AssetTypeId 
FROM         	sessINV_ASSET_TYPE
WHERE	CreatedBy = @tech

