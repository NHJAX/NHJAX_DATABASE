
create PROCEDURE [dbo].[procENET_TICKET_ATTACHMENT_UpdateDeletedDate]
(
	@ta bigint,
	@dby int
)
AS
UPDATE TICKET_ATTACHMENT
SET DeletedDate = Getdate(),
	DeletedBy = @dby
WHERE TicketAttachmentId = @ta




