CREATE PROCEDURE [dbo].[upsessInvAssetTypeInsert]
(
	@atyp int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_ASSET_TYPE
	(
	AssetTypeId,
	Createdby
	)
	VALUES
	(
	@atyp,
	@cby
	);
	COMMIT TRANSACTION
