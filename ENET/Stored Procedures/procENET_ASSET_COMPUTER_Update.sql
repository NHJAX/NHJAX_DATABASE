create PROCEDURE [dbo].[procENET_ASSET_COMPUTER_Update]
(
	@id int,
	@ram decimal(19,4),
	@hd decimal(19,4),
	@cpu decimal(19,4),
	@dual bit
)
AS
UPDATE ASSET_COMPUTER
SET	RAMSize = @ram,
	HardDriveSize = @hd,
	CPUSpeed = @cpu,
	DualMonitor = @dual
WHERE AssetId = @id

