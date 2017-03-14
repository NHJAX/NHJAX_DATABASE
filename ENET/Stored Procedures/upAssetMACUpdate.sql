CREATE PROCEDURE [dbo].[upAssetMACUpdate]
(
	@ast int,
	@mac varchar(50),
	@uby int
)
AS
UPDATE ASSET_MAC
SET 	AssetId = @ast,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE MACAddress = @mac
