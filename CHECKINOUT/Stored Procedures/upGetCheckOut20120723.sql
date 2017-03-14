create PROCEDURE [dbo].[upGetCheckOut20120723]
WITH RECOMPILE 
AS

select distinct IsNull(s.firstname,'') as FirstName, IsNull(s.lastname,'') as LastName, 
IsNull(s.mi,'') as MI, IsNull(s.ssn,'') as SSN, IsNull(s.status,'') as Status, s.checkoutdate,
l.Description as Location
from ScheduledToCheckOut s 
left outer join chkmaster c on s.ssn=c.ssn 
left outer join site l on s.siteid=l.siteid
where datediff(d, s.checkoutdate, getdate()) > 5 and 
(s.checkedout is null and (chkid not in (select chkid from checkout) or chkid is null))
order by s.checkoutdate
