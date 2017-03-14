create PROCEDURE [dbo].[upFindSSN20120723]
(
	@SSN	varchar(11)
)
WITH RECOMPILE 
AS
select IsNull(FirstName,'') as FirstName, IsNull(MI, '') as MI, IsNull(LastName,'') as LastName, IsNull(Status,'') as Status, 
SSN, IsNull(SiteID,0) as SiteID 
from chkmaster where SSN=@SSN and chkid not in (select chkid from checkout)
