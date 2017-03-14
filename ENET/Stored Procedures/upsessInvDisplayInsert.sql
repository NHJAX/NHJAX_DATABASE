CREATE PROCEDURE [dbo].[upsessInvDisplayInsert]
(
	@disp int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_DISPLAY
	(
	DisplayColumnId,
	Createdby
	)
	VALUES
	(
	@disp,
	@cby
	);
	COMMIT TRANSACTION
