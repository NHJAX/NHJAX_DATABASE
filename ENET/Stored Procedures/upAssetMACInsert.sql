CREATE PROCEDURE [dbo].[upAssetMACInsert]
(
	@ast int,
	@mac varchar(50),
	@cby int,
	@uby int
)
AS
INSERT INTO ASSET_MAC
(
	AssetId, 
	MACAddress, 
	CreatedBy,
	UpdatedBy
)
VALUES
(
	@ast, 
	@mac, 
	@cby,
	@uby
)
