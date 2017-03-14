CREATE PROCEDURE [dbo].[upsessInvManufacturerInsert]
(
	@man int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_MANUFACTURER
	(
	ManufacturerId,
	Createdby
	)
	VALUES
	(
	@man,
	@cby
	);
	COMMIT TRANSACTION
