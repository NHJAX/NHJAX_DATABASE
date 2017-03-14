
CREATE PROCEDURE [dbo].[upAssetMACSelect]
(
	@mac varchar(50)
)
AS
SELECT ASSET_MAC.AssetId,
	ASSET_MAC.MACAddress,
	ASSET_MAC.CreatedDate,
	ASSET_MAC.CreatedBy,
	ASSET_MAC.UpdatedDate,
	ASSET_MAC.UpdatedBy,
	ASSET_MAC.AssetMACId
FROM ASSET_MAC
INNER JOIN ASSET
ON ASSET_MAC.AssetId = ASSET.AssetId
WHERE ASSET_MAC.MACAddress = @mac
AND ASSET.DispositionId IN (0,1,14,15,19,20,21)


