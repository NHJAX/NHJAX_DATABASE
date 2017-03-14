create PROCEDURE [dbo].[procENET_ASSET_COMPUTER_Insert]
(
	@id int,
	@ram decimal(19,4),
	@hd decimal(19,4),
	@cpu decimal(19,4),
	@dual bit
)
AS
INSERT INTO ASSET_COMPUTER
(
	AssetId,
	RAMSize,
	HardDriveSize,
	CPUSpeed,
	DualMonitor
)
VALUES
(
	@id,
	@ram,
	@hd,
	@cpu,
	@dual
)

