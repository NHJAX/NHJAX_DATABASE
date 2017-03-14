create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_UpdateIndividualRemarks]
(
	@asg int,
	@rem text
)
AS
UPDATE TICKET_ASSIGNMENT
SET Remarks = @rem
WHERE AssignmentId = @asg



