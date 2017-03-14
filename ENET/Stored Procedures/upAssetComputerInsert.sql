CREATE PROCEDURE [dbo].[upAssetComputerInsert]
(
	@ast int,
	@ram decimal,
	@cpu decimal,
	@hd decimal,
	@ver varchar(10)
)
AS
INSERT INTO ASSET_COMPUTER
(
	AssetId, 
	RAMSize, 
	CPUSpeed, 
	HardDriveSize, 
	AIMVersion
)
VALUES
(
	@ast,
	@ram, 
	@cpu, 
	@hd,
	@ver
)

