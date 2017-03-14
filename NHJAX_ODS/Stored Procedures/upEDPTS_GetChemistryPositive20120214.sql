


CREATE PROCEDURE [dbo].[upEDPTS_GetChemistryPositive20120214] 
(
	@pat	numeric,
	@sdate	smalldatetime,
	@edate	smalldatetime,
	@ord	numeric
)
WITH RECOMPILE
AS
BEGIN
select 
lr.OrderId, 
lr.PatientId, 
p.PatientKey, 
p.FullName as PatientName, 
FamilyMemberPrefixCode as FMP, 
Right(SponsorSSN,4) as SSN, 
p.Phone,  
IsNull(loc.HospitalLocationName,'') as Clinic, 
IsNull(prov.ProviderName,'') as ProviderName, 
TakenDate, 
IsNull(CollectionSampleDesc,'') as Specimen,  
LabTestDesc,
'' AS Twelve,
'' AS Thirteen, 
ChemistryResult,
NULL as examdatetime, 
'' as ExamNumber, 
'' as ProcCode, 
IsNull(prov.DutyPhone,'') as DutyPhone, 
IsNull(prov.PagerNumber,'') as PagerNumber,
op.OrderPriorityDesc as Priority, 
IsNull(PatientDispositionDesc,'') as Disposition,
IsNull(dt.DiagnosisFreeText, '') as DiagnosisFreeText
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
left outer join Order_Priority op 
on po.OrderPriorityID=op.OrderPriorityID
left outer join patient_encounter en 
on po.PatientEncounterID=en.PatientEncounterID
left outer join patient_disposition pd 
on en.PatientDispositionID=pd.PatientDispositionId
left outer join encounter_diagnosis_free_text dt 
on po.PatientEncounterID=dt.PatientEncounterID
where po.OrderId=@ord 
and  po.PatientID=@pat
and TakenDate 
between dbo.StartofDay(@sdate)
and dbo.EndofDay(@edate) and 
LEFT(ChemistryResult,1)='P'
order by TakenDate
END


