




CREATE PROCEDURE [dbo].[procENet_DeveloperTicketSelectbySystem]
(
	@usr 	int = 0,
	@stat	int = 0,
	@sys	int
)
AS

	
IF @stat = 0
BEGIN
SELECT
	TKT.TicketId, 
	TKT.TicketNumber, 
	TKT.ProblemTypeId, 
	TKT.SystemNameId, 
	TKT.SoftwareId, 
	TKT.AudienceId, 
	TKT.CustomerName, 
	TKT.Comments, 
    TKT.ClosedDate, 
	ASG.Hours,
	TKT.PriorityId,
	ASG.StatusId,
	TKT.EstimatedHours,
	TKT.OpenDate,
	SYS.SystemDesc
FROM	TICKET TKT 
	INNER JOIN TICKET_ASSIGNMENT ASG 
	ON TKT.TicketId = ASG.TicketId
	INNER JOIN SYSTEM_TYPE SYS
	ON TKT.SystemNameId = SYS.SystemId
WHERE TKT.ProblemTypeId IN (39,40,41)
	AND TKT.SystemNameId = @sys
	AND ASG.AssignedTo = @usr
	AND TKT.StatusId < 3 AND ASG.StatusId < 3
ORDER BY TKT.PriorityId, TKT.OpenDate

END
ELSE
BEGIN
SELECT
	TKT.TicketId, 
	TKT.TicketNumber, 
	TKT.ProblemTypeId, 
	TKT.SystemNameId, 
	TKT.SoftwareId, 
	TKT.AudienceId, 
	TKT.CustomerName, 
	TKT.Comments, 
    TKT.ClosedDate, 
	ASG.Hours,
	TKT.PriorityId,
	ASG.StatusId,
	TKT.EstimatedHours,
	TKT.OpenDate,
	SYS.SystemDesc
FROM	TICKET TKT 
	INNER JOIN TICKET_ASSIGNMENT ASG 
	ON TKT.TicketId = ASG.TicketId
	INNER JOIN SYSTEM_TYPE SYS
	ON TKT.SystemNameId = SYS.SystemId
WHERE TKT.ProblemTypeId IN (39,40,41)
	AND TKT.SystemNameId = @sys
	AND ASG.AssignedTo = @usr
ORDER BY TKT.PriorityId, TKT.OpenDate
END








