create PROCEDURE [dbo].[procENET_sessInvAudience_Insert]
(
	@aud bigint,
	@cby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO sessINV_AUDIENCE
	(
	AudienceId,
	Createdby
	)
	VALUES
	(
	@aud,
	@cby
	);
	COMMIT TRANSACTION



