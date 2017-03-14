CREATE PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_UpdateAssignmentClosed]
(
	@asg int,
	@rem text,
	@usr int, 
	@dt datetime,
	@hrs decimal(18,2),
	@tier int
)
AS
UPDATE TICKET_ASSIGNMENT
SET StatusId = 3, 
	ClosedBy = @usr, 
	ClosedDate = @dt, 
	Remarks = @rem, 
	[Hours] = @hrs,
	TierId = @tier
WHERE AssignmentId = @asg



