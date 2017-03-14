create PROCEDURE [dbo].[upFindName20120723]
(
	@First	varchar(30),
	@Last	varchar(30)
)
WITH RECOMPILE 
AS
Declare @FirstName varchar(30), @LastName varchar(30)
SET @FirstName=@First + '%'
SET @LastName=@Last + '%'
select distinct IsNull(FirstName,'') as FirstName, IsNull(left(MI,1), '') as MI, 
IsNull(LastName,'') as LastName, IsNull(Status,'') as Status, SSN, 
IsNull(c.SiteID,0) as SiteID, IsNull(s.Description,'') as Location
from chkmaster c
left outer join site s on c.siteid=s.siteid
where lastname like @LastName and firstname like @FirstName and chkid not in (select chkid from checkout)
order by lastname, firstname, mi
