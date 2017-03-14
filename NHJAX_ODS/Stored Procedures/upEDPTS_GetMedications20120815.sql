

CREATE PROCEDURE [dbo].[upEDPTS_GetMedications20120815] 
(
	@pat	bigint,
	@sdate	smalldatetime	
)
WITH RECOMPILE
AS


BEGIN
DECLARE @start datetime
DECLARE @end datetime

SET @start = dbo.StartofDay(@sdate)
SET @end = dbo.EndofDay(@sdate)

select rx.PrescriptionId,
rx.PatientID, 
DrugDesc as Medication, 
rx.OrderDateTime, 
prov.ProviderName as Provider 
from prescription rx
join drug d 
on rx.DrugID=d.DrugID
left outer join provider prov 
on rx.ProviderID=prov.ProviderID
where PatientID=@pat 
and rx.OrderDateTime 
between @start 
and @end

END

