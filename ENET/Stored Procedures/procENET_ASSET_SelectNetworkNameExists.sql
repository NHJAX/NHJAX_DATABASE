create PROCEDURE [dbo].[procENET_ASSET_SelectNetworkNameExists]
(
	@net varchar(100)
)
AS
SELECT COUNT(ASSET.AssetId)
FROM ASSET
WHERE NetworkName = @net


