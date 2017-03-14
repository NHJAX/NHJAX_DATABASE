CREATE PROCEDURE [dbo].[upsessInvAssetSubTypeDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_ASSET_SUBTYPE
WHERE	CreatedBy = @tech

