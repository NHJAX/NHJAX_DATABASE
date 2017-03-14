create PROCEDURE [dbo].[procENET_TICKET_UpdateSoftware]
(
	@tik int,
	@uby int,
	@sft int
)
AS
UPDATE TICKET SET
	SoftwareId = @sft,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE TicketId = @tik;


