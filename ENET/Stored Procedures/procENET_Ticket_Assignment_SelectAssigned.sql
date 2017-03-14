
CREATE PROCEDURE [dbo].[procENET_Ticket_Assignment_SelectAssigned]
(
	@ticket int
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
WHERE StatusId = 2
AND TicketId = @ticket

END

