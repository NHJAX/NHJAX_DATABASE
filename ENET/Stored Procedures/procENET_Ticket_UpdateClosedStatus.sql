create PROCEDURE [dbo].[procENET_Ticket_UpdateClosedStatus]
(
	@ClsBy		int,
	@ClsDt		datetime,
	@Ticket		int
)
 AS

UPDATE TICKET 
SET StatusId = 3, 
ClosedBy = @ClsBy, 
ClosedDate = @ClsDt 
WHERE TicketId = @Ticket


