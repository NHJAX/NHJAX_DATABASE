﻿


CREATE PROCEDURE [dbo].[upEDPTS_GetLabResults20120214] 
(
	@pat bigint,
	@sdate	smalldatetime,
	@edate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
/* Bacteriology */
select 
po.OrderId, 
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
'' as Medication, '' as Treated, '' as Certified, 
'' as Comments, 
'Bacteriology' as Type,
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
where (po.LocationId=174 or po.LocationId=17) 
and TakenDate 
between dbo.startofday(@sdate) 
and dbo.endofday(@edate)
and po.PatientID=@pat
UNION
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
'' as Comments, 
'Chemistry' as Type,
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
on po.PatientID=u.PatientID AND po.OrderID=u.OrderID
where (po.LocationId=174 or po.LocationId=17) 
and ChemistryResult in ('P', 'POS', 'POSITIVE') 
and TakenDate 
between dbo.startofday(@sdate) 
and dbo.endofday(@edate)
and po.PatientID=@pat
order by TakenDate
END


