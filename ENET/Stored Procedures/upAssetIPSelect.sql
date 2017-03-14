CREATE PROCEDURE [dbo].[upAssetIPSelect]
(
	@asset int,
	@ip varchar(50)
)
AS
SELECT AssetIPId,
	AssetId,
	IPAddress,
	CreatedDate,
	CreatedBy
FROM ASSET_IP
WHERE AssetId = @asset 
	AND IPAddress = @ip

