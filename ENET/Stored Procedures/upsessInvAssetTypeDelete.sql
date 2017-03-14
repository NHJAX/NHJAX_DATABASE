CREATE PROCEDURE [dbo].[upsessInvAssetTypeDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_ASSET_TYPE
WHERE	CreatedBy = @tech

