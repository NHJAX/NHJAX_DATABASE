CREATE PROCEDURE [dbo].[upAssetComputerSelect]
(
	@ast int
)
AS
SELECT RAMSize,
	CPUSpeed,
	HardDriveSize,
	AIMVersion,
	CreatedDate,
	UpdatedDate
	FROM ASSET_COMPUTER
	WHERE AssetId = @ast

