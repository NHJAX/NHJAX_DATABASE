create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_UpdateStatusClosed]
(
	@tik int,
	@rem text,
	@usr int, 
	@dt datetime,
	@hrs decimal(18,2)
)
AS
UPDATE TICKET_ASSIGNMENT
SET StatusId = 3, 
	ClosedBy = @usr, 
	ClosedDate = @dt, 
	Remarks = @rem, 
	[Hours] = @hrs
WHERE StatusId < 3 
AND TicketId = @tik



