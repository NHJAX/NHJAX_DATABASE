CREATE PROCEDURE [dbo].[upsessInvModelInsert]
(
	@mod int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_MODEL
	(
	ModelId,
	Createdby
	)
	VALUES
	(
	@mod,
	@cby
	);
	COMMIT TRANSACTION
