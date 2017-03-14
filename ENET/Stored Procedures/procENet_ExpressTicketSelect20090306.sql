create PROCEDURE [dbo].[procENet_ExpressTicketSelect20090306]
(
	@usr 		int = 0,
	@begdate 	datetime = '1/1/1900',
	@enddate 	datetime = '1/1/1900',
	@prob		int = 0,
	@debug 	bit = 0
)
AS

	DECLARE @sql nvarchar(4000)
	DECLARE @param nvarchar(4000)

IF @begdate = '1/1/1900'
	SET @begdate = getdate()

IF @enddate = '1/1/1900'
	SET @enddate = getdate()

SELECT @sql = 'SELECT
	TKT.TicketId, 
	TKT.TicketNumber, 
	TKT.ProblemTypeId, 
	TKT.SystemNameId, 
	TKT.SoftwareId, 
	TKT.AudienceId, 
	TKT.CustomerName, 
	TKT.Comments, 
    TKT.ClosedDate, 
	ASG.Hours
FROM	TICKET TKT 
	INNER JOIN TICKET_ASSIGNMENT ASG 
	ON TKT.TicketId = ASG.TicketId
WHERE TKT.ClosedDate >= dbo.StartofDay(@begdate)
	AND TKT.ClosedDate <= dbo.EndofDay(@enddate) '

IF @usr > 0
SELECT @sql = @sql + 'AND ASG.AssignedTo = @usr '

IF @prob > 0
SELECT @sql = @sql + 'AND TKT.ProblemTypeId = @prob '

IF @debug > 0
	PRINT @sql
	PRINT @usr
	PRINT @begdate
	PRINT @enddate

SELECT @param =	 '@usr int,
			@begdate datetime,
			@enddate datetime,
			@prob int '

EXEC sp_executesql @sql, @param, @usr, @begdate, @enddate, @prob
