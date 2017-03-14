CREATE PROCEDURE [dbo].[upENet_TicketAssignmentUpdate]
(
	@tic		int,
	@hours		decimal(18,3)
)
 AS

UPDATE TICKET_ASSIGNMENT
	SET Hours = @hours
WHERE TicketId = @tic
