create PROCEDURE [dbo].[procAIM_ASSET_COMPUTER_Select]
(
	@id int
)
AS
SELECT RAMSize,
	HardDriveSize,
	CPUSpeed,
	AIMVersion,
	DualMonitor
FROM ASSET_COMPUTER
WHERE AssetId = @id

