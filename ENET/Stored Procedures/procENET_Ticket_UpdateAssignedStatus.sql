create PROCEDURE [dbo].[procENET_Ticket_UpdateAssignedStatus]
(
	@AsgBy		int,
	@AsgDt		datetime,
	@Ticket		int
)
 AS

UPDATE TICKET
SET StatusId = 2, 
AssignedBy = @AsgBy, 
AssignedDate = @AsgDt 
WHERE TicketId = @Ticket


