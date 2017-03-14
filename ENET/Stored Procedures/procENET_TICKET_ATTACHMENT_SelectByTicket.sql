
CREATE PROCEDURE [dbo].[procENET_TICKET_ATTACHMENT_SelectByTicket]
(
	@tik int
)
AS
SELECT 
	TicketAttachmentId,
	TicketId,
	AttachmentName,
	ShortName,
	CreatedDate,
	CreatedBy
FROM TICKET_ATTACHMENT
WHERE TicketId = @tik
AND DeletedDate IS NULL




