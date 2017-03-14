create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_UpdateRemarks]
(
	@tik int,
	@rem text
)
AS
UPDATE TICKET_ASSIGNMENT
SET Remarks = @rem
WHERE StatusId = 2
AND TicketId = @tik



