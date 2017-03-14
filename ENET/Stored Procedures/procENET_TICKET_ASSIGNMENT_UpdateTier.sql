create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_UpdateTier]
(
	@asg int,
	@tier int
)
AS
UPDATE TICKET_ASSIGNMENT
SET TierId = @tier
WHERE AssignmentId = @asg



