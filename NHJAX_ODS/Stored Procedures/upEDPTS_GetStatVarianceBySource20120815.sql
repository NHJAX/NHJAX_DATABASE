
create PROCEDURE [dbo].[upEDPTS_GetStatVarianceBySource20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
/* Bacteriology */
select count(*) as Number, 
CollectionSampleDesc as Source
from lab_result lr
left outer join patient_order po 
on lr.OrderId=po.OrderId
left outer join patient p 
on lr.PatientId=p.PatientId
left outer join family_member_prefix f 
on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
left outer join hospital_location loc 
on po.LocationId=loc.HospitalLocationId
left outer join provider prov 
on po.OrderingProviderId=prov.ProviderId
left outer join collection_sample cs 
on po.CollectionSampleId=cs.CollectionSampleId
left outer join lab_result_bacteriology_test bt 
on lr.LabResultId=bt.LabResultId
left outer join lab_test t 
on bt.LabTestId=t.LabTestId
join lab_result_organism o 
on bt.LabResultBacteriologyTestId=o.LabResultBacteriologyTestId
left outer join etiology e 
on o.EtiologyId=e.EtiologyId
where (po.LocationId=174 or po.LocationId=17) 
and TakenDate between @StartDate and @EndDate
group by CollectionSampleDesc
order by Number DESC
END
