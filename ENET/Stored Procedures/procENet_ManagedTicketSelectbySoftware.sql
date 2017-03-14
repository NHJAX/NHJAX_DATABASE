




CREATE PROCEDURE [dbo].[procENet_ManagedTicketSelectbySoftware]
(
	@usr 	int = 0,
	@stat	int = 0,
	@soft	int
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
	ASG.StatusId,
	TKT.OpenDate,
	SYS.SystemDesc,
	PROB.ProblemTypeDesc,
	SOFT.SoftwareDesc,
	AUD.DisplayName,
	TKT.TicketLocation,
	TECH.UPhone,
	STAT.StatusDesc,
	TKT.CreatedFor
FROM	TICKET AS TKT 
	INNER JOIN TICKET_ASSIGNMENT AS ASG 
	ON TKT.TicketId = ASG.TicketId
	INNER JOIN SYSTEM_TYPE AS SYS
	ON TKT.SystemNameId = SYS.SystemId
	INNER JOIN PROBLEM_TYPE AS PROB
	ON TKT.ProblemTypeId = PROB.ProblemTypeId
	INNER JOIN SOFTWARE_NAME AS SOFT
	ON TKT.SoftwareId = SOFT.SoftwareId
	INNER JOIN AUDIENCE AS AUD
	ON TKT.AudienceId = AUD.AudienceId
	INNER JOIN TECHNICIAN AS TECH
	ON TKT.CreatedFor = TECH.UserId
	INNER JOIN TICKET_STATUS AS STAT
	ON ASG.StatusId = STAT.StatusId
WHERE TKT.SoftwareId = @soft
	AND ASG.AssignedTo = @usr
	AND TKT.StatusId < 3 AND ASG.StatusId < 3
ORDER BY TKT.OpenDate

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
	ASG.StatusId,
	TKT.OpenDate,
	SYS.SystemDesc,
	PROB.ProblemTypeDesc,
	SOFT.SoftwareDesc,
	AUD.DisplayName,
	TKT.TicketLocation,
	TECH.UPhone,
	STAT.StatusDesc,
	TKT.CreatedFor
FROM	TICKET AS TKT 
	INNER JOIN TICKET_ASSIGNMENT AS ASG 
	ON TKT.TicketId = ASG.TicketId
	INNER JOIN SYSTEM_TYPE AS SYS
	ON TKT.SystemNameId = SYS.SystemId
	INNER JOIN PROBLEM_TYPE AS PROB
	ON TKT.ProblemTypeId = PROB.ProblemTypeId
	INNER JOIN SOFTWARE_NAME AS SOFT
	ON TKT.SoftwareId = SOFT.SoftwareId
	INNER JOIN AUDIENCE AS AUD
	ON TKT.AudienceId = AUD.AudienceId
	INNER JOIN TECHNICIAN AS TECH
	ON TKT.CreatedFor = TECH.UserId
	INNER JOIN TICKET_STATUS AS STAT
	ON ASG.StatusId = STAT.StatusId
WHERE TKT.SoftwareId = @soft
	AND ASG.AssignedTo = @usr
ORDER BY TKT.OpenDate
END








