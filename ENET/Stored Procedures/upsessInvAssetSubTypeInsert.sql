CREATE PROCEDURE [dbo].[upsessInvAssetSubTypeInsert]
(
	@astyp int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_ASSET_SUBTYPE
	(
	AssetSubTypeId,
	Createdby
	)
	VALUES
	(
	@astyp,
	@cby
	);
	COMMIT TRANSACTION
