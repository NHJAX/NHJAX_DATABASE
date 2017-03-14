
CREATE PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_Select]
(
	@asg int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	Remarks,
	AssignmentDate,
	ClosedDate,
	[Hours],
	TierId,
	AssignedTo
FROM TICKET_ASSIGNMENT
WHERE AssignmentId = @asg

END

