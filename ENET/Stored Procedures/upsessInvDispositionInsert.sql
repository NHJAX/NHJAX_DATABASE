CREATE PROCEDURE [dbo].[upsessInvDispositionInsert]
(
	@disp int,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_DISPOSITION
	(
	DispositionId,
	Createdby
	)
	VALUES
	(
	@disp,
	@cby
	);
	COMMIT TRANSACTION

