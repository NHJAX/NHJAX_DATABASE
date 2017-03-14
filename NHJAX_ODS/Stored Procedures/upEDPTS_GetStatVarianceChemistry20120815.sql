
create PROCEDURE [dbo].[upEDPTS_GetStatVarianceChemistry20120815] 
(
	@sdate	smalldatetime,
	@edate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
/* Chemistry */
select po.OrderId, 
lr.PatientId, 
p.FullName as PatientName, 
FamilyMemberPrefixCode as FMP, 
Right(SponsorSSN,4) as SSN, 
IsNull(loc.HospitalLocationName,'') as Clinic, 
IsNull(prov.ProviderName,'') as ProviderName, 
TakenDate, 
IsNull(CollectionSampleDesc,'') as Source, 
'' as GramStain, 
'' as BacteriologyResult, 
LabTestDesc, 
LabTestDesc as Organism, 
'' as Medication, 
'' as Treated, 
'' as Certified, 
'' as Comments, 'Chemistry' as Type,
IsNull(FollowUpComplete,0) as FollowUpComplete
from lab_result lr
left outer join patient p 
on lr.PatientId=p.PatientId
left outer join family_member_prefix f 
on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
left outer join lab_result_chemistry_result cr 
on lr.LabResultId=cr.LabResultId
left outer join lab_test t 
on cr.LabTestId=t.LabTestId
left outer join patient_order po 
on lr.OrderId=po.OrderId
left outer join hospital_location loc 
on po.LocationId=loc.HospitalLocationId
left outer join provider prov 
on po.OrderingProviderId=prov.ProviderId
left outer join collection_sample cs 
on po.CollectionSampleId=cs.CollectionSampleId
left outer join [nhjax-sql2].edpts.dbo.ER_FollowUp u 
on po.PatientID=u.PatientID 
AND po.OrderID=u.OrderID
where (po.LocationId=174 
or po.LocationId=17) 
and ChemistryResult 
in ('P', 'POS', 'POSITIVE') 
and TakenDate between @sdate and @edate
order by TakenDate
END
