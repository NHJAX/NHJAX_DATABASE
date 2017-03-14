CREATE PROCEDURE [dbo].[procENet_ExpressTicketSelect]
(
	@usr 		int = 0,
	@begdate 	datetime = '1/1/1900',
	@enddate 	datetime = '1/1/1900',
	@prob		int = 0
)
AS

IF @begdate = '1/1/1900'
	SET @begdate = getdate()

IF @enddate = '1/1/1900'
	SET @enddate = getdate()

If @prob = 0
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
	ASG.Hours
FROM	TICKET TKT 
	INNER JOIN TICKET_ASSIGNMENT ASG 
	ON TKT.TicketId = ASG.TicketId
WHERE TKT.ClosedDate >= dbo.StartofDay(@begdate)
	AND TKT.ClosedDate <= dbo.EndofDay(@enddate) 
AND ASG.AssignedTo = @usr 
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
	ASG.Hours
FROM	TICKET TKT 
	INNER JOIN TICKET_ASSIGNMENT ASG 
	ON TKT.TicketId = ASG.TicketId
WHERE TKT.ClosedDate >= dbo.StartofDay(@begdate)
	AND TKT.ClosedDate <= dbo.EndofDay(@enddate) 
AND ASG.AssignedTo = @usr 
AND TKT.ProblemTypeId = @prob 
END


