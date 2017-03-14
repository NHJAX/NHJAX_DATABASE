create PROCEDURE [dbo].[procENET_TICKET_UpdateAudience]
(
	@tik int,
	@uby int,
	@aud bigint
)
AS
UPDATE TICKET SET
	AudienceId = @aud,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE TicketId = @tik;


