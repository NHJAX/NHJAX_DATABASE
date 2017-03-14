
create PROCEDURE [dbo].[procENET_TICKET_ATTACHMENT_Count]
(
	@tik int
)
AS
SELECT
	Count(TicketAttachmentId)
FROM TICKET_ATTACHMENT
WHERE TicketId = @tik

	



