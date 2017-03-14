

CREATE PROCEDURE [dbo].[upEDPTS_GetStatVarianceBacteriology20120214] 
(
	@sdate	smalldatetime,
	@edate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
/* Bacteriology */
select po.OrderId, 
lr.PatientId, 
p.FullName as PatientName, 
FamilyMemberPrefixCode as FMP, 
Right(SponsorSSN,4) as SSN, 
loc.HospitalLocationName as Clinic, 
prov.ProviderName as ProviderName, 
TakenDate, 
IsNull(CollectionSampleDesc,'') as Source, 
IsNull(GramStain,'') as GramStain, 
IsNull(BacteriologyResult,'') as BacteriologyResult, 
LabTestDesc, 
EtiologyDesc as Organism, 
'' as Medication, 
'' as Treated, 
'' as Certified, 
'' as Comments, 'Bacteriology' as Type,
IsNull(FollowUpComplete,0) as FollowUpComplete
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
left outer join [nhjax-sql2].edpts.dbo.ER_FollowUp u 
on po.PatientID=u.PatientID 
AND po.OrderID=u.OrderID
where (po.LocationId=174 
or po.LocationId=17) 
and TakenDate 
between dbo.StartofDay(@sdate )
and dbo.EndofDay(@edate)
order by TakenDate
END

