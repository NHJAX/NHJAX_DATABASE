create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_SelectOpenCount]
(
	@tik int
)
AS
SELECT Count(AssignmentId)
FROM TICKET_ASSIGNMENT 
WHERE TicketId = @tik 
	AND StatusId < 3



