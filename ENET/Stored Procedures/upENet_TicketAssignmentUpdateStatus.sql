
create PROCEDURE [dbo].[upENet_TicketAssignmentUpdateStatus]
(
	@tic		int,
	@hours		decimal(18,3),
	@cby		int
)
 AS

UPDATE TICKET_ASSIGNMENT
	SET Hours = @hours,
	ClosedBy = @cby,
	ClosedDate = getdate(),
	StatusId = 3
WHERE TicketId = @tic

