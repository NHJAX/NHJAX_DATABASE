CREATE PROCEDURE [dbo].[upCountFeedback]
(
	@fromDate smalldatetime,
	@toDate smalldatetime
)
AS
select count(*) as tickets, 0 as negative, 0 as positive from ticket 
where createddate >= dbo.StartofDay(@fromDate) and createddate <= dbo.EndofDay(@toDate)
union
select 0 as tickets, count(ticketid) as negative, 0 as positive from ticket_feedback 
where customersatisfied = 0 and createddate >= dbo.StartofDay(@fromDate) and createddate <= dbo.EndofDay(@toDate)
union
select 0 as tickets, 0 as negative, count(ticketid) as positive from ticket_feedback
where customersatisfied = 1 and createddate >= dbo.StartofDay(@fromDate) and createddate <= dbo.EndofDay(@toDate)
