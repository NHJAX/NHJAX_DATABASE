




CREATE PROCEDURE [dbo].[upENet_DeveloperTicketSelect]
(
	@usr 	int = 0,
	@stat	int = 0,
	@debug 	bit = 0
)
AS

	DECLARE @sql nvarchar(4000)
	DECLARE @param nvarchar(4000)

SELECT @sql = 'SELECT
	TKT.TicketId, 
	TKT.TicketNumber, 
	TKT.ProblemTypeId, 
	TKT.SystemNameId, 
	TKT.SoftwareId, 
	TKT.DepartmentId, 
	TKT.CustomerName, 
	TKT.Comments, 
    TKT.ClosedDate, 
	ASG.Hours,
	TKT.PriorityId,
	ASG.StatusId,
	TKT.EstimatedHours,
	TKT.OpenDate
FROM	TICKET TKT 
	INNER JOIN TICKET_ASSIGNMENT ASG 
	ON TKT.TicketId = ASG.TicketId
WHERE TKT.ProblemTypeId = 41 '

IF @usr > 0
SELECT @sql = @sql + 'AND ASG.AssignedTo = @usr '

IF @stat = 0
SELECT @sql = @sql + 'AND TKT.StatusId < 3 AND ASG.StatusId < 3 '

SELECT @sql = @sql + 'ORDER BY TKT.PriorityId, TKT.OpenDate '

IF @debug > 0
	PRINT @sql
	PRINT @usr
	PRINT @stat

SELECT @param =	 '@usr int,
			@stat int '

EXEC sp_executesql @sql, @param, @usr, @stat





