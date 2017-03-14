CREATE PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_SelectListAssignments]
(
	@tik int
)
AS
SELECT A.AssignmentId, 
	TECH2.ULName AS ToLName, 
	TECH2.UFName AS ToFName, 
	TECH2.UMName AS ToMName, 
	TECH.ULName AS ByLName, 
	TECH.UFName AS ByFName, 
	TECH.UMName AS ByMName, 
	TICKET_STATUS.StatusDesc, 
	A.AssignmentDate, 
	A.ClosedDate, 
	TECH3.ULName AS CLName, 
	TECH3.UFName AS CFName, 
	TECH3.UMName AS CMName, 
	A.TicketId, 
	A.Remarks, 
	A.[Hours],
	A.TierId
FROM TICKET_ASSIGNMENT A 
	INNER JOIN TECHNICIAN TECH2 
	ON A.AssignedTo = TECH2.UserId 
	INNER JOIN TECHNICIAN TECH 
	ON A.AssignedBy = TECH.UserId 
	INNER JOIN TICKET_STATUS 
	ON A.StatusId = TICKET_STATUS.StatusId 
	LEFT OUTER JOIN TECHNICIAN TECH3 
	ON A.ClosedBy = TECH3.UserId 
WHERE A.TicketId = @tik 
ORDER BY A.AssignmentDate DESC



