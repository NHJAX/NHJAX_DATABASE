CREATE PROCEDURE [dbo].[upAssetComputerUpdate]
(
	@ram decimal,
	@cpu decimal,
	@hd decimal,
	@ver varchar(10),
	@udate datetime,
	@ast int
)
AS
UPDATE ASSET_COMPUTER SET
	RAMSize = @ram,
	CPUSpeed = @cpu,
	HardDriveSize = @hd,
	AIMVersion = @ver,
	UpdatedDate = @udate
WHERE AssetId = @ast

