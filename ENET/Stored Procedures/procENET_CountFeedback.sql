create PROCEDURE [dbo].[procENET_CountFeedback]
(
	@sdate datetime,
	@edate datetime
)
AS
SELECT COUNT(*) as Tickets, 
	0 as negative, 
	0 as positive from TICKET 
WHERE CreatedDate BETWEEN dbo.StartofDay(@sdate) 
	AND dbo.EndofDay(@edate)
UNION
SELECT 0 as tickets, 
	count(TicketId) as negative, 
	0 as positive 
FROM TICKET_FEEDBACK 
WHERE customersatisfied = 0 
	AND CreatedDate BETWEEN dbo.StartofDay(@sdate) 
	AND dbo.EndofDay(@edate)
UNION
SELECT 0 as tickets, 
	0 as negative, 
	count(ticketid) as positive 
FROM TICKET_FEEDBACK
WHERE customersatisfied = 1 
	AND CreatedDate BETWEEN dbo.StartofDay(@sdate) 
	AND dbo.EndofDay(@edate)
