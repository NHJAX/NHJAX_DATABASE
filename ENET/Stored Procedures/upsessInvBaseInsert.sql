create PROCEDURE [dbo].[upsessInvBaseInsert]
(
	@bas int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_BASE
	(
	BaseId,
	Createdby
	)
	VALUES
	(
	@bas,
	@cby
	);
	COMMIT TRANSACTION

