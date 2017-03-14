CREATE PROCEDURE [dbo].[upAssetIPInsert]
(
	@asset int,
	@ip varchar(50),
	@user int
)
AS
INSERT INTO ASSET_IP
(
	AssetId, 
	IPAddress, 
	CreatedBy
)
VALUES
(
	@asset, 
	@ip, 
	@user
)

