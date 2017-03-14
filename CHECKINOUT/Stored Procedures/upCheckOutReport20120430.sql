create PROCEDURE [dbo].[upCheckOutReport20120430]
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime
)
WITH RECOMPILE 
AS

select distinct IsNull(s.LastName,'') as LastName, IsNull(s.firstname,'') as FirstName, 
IsNull(s.mi,'') as MI, IsNull(s.ssn,'') as SSN, IsNull(s.status,'') as Status, 
l.Description as Location, s.CheckOutDate as ScheduledCheckOutDate, s.CheckedOut as ActualCheckOutDate
from ScheduledToCheckOut s 
left outer join chkmaster c on s.ssn=c.ssn 
left outer join site l on s.siteid=l.siteid
where s.CheckOutDate between @StartDate and @EndDate
UNION
select LastName, FirstName, MI, SSN, IsNull(Status, '') as Status, 
IsNull(l.Description, '') as Location, '' as ScheduledCheckOutDate, 
dtChkOut as ActualCheckOutDate
from 
chkmaster
join checkout on chkmaster.chkid=checkout.chkid
left outer join site l on chkmaster.siteid=l.siteid
where ssn not in (select ssn from scheduledtocheckout)
and dtChkOut between @StartDate and @EndDate
ORDER BY LastName, FirstName, MI
