CREATE VIEW [dbo].[vwCurrentAssignment]
AS
SELECT     TicketId, MAX(AssignmentDate) AS CurrentAssignment
FROM         dbo.TICKET_ASSIGNMENT
GROUP BY TicketId

