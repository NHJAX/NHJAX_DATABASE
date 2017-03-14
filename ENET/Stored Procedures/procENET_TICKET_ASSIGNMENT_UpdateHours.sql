create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_UpdateHours]
(
	@asg int,
	@hrs decimal(18,2)
)
AS
UPDATE TICKET_ASSIGNMENT
SET [Hours] = @hrs
WHERE AssignmentId = @asg



