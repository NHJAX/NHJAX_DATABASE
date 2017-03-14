CREATE PROCEDURE [dbo].[GetOrganism20120815]
(
	@PatientID	numeric,
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@OrderID	numeric
)
WITH RECOMPILE
AS
BEGIN
select  po.OrderID, po.PatientID, p.FullName as PatientName, FamilyMemberPrefixCode as FMP, Right(SponsorSSN,4) as SSN, p.Phone, loc.HospitalLocationName as Clinic, 
prov.ProviderName as ProviderName, TakenDate, IsNull(CollectionSampleDesc,'') as Specimen, 
GramStain, BacteriologyResult, LabTestDesc, EtiologyDesc as Organism, 
'' as ExamNumber, '' as ProcCode, IsNull(prov.DutyPhone,'') as DutyPhone, 
IsNull(prov.PagerNumber, '') as PagerNumber, op.OrderPriorityDesc as Priority, IsNull(PatientDispositionDesc,'') as Disposition,
IsNull(dt.DiagnosisFreeText, '') as DiagnosisFreeText
from lab_result lr
left outer join patient_order po on lr.OrderId=po.OrderId
left outer join patient p on po.PatientId=p.PatientId
left outer join family_member_prefix f on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
left outer join hospital_location loc on po.LocationId=loc.HospitalLocationId
left outer join provider prov on po.OrderingProviderId=prov.ProviderId
left outer join collection_sample cs on po.CollectionSampleId=cs.CollectionSampleId
left outer join lab_result_bacteriology_test bt on lr.LabResultId=bt.LabResultId
left outer join lab_test t on bt.LabTestId=t.LabTestId
join lab_result_organism o on bt.LabResultBacteriologyTestId=o.LabResultBacteriologyTestId
left outer join etiology e on o.EtiologyId=e.EtiologyId
left outer join order_priority op on po.OrderPriorityID=op.OrderPriorityID
left outer join patient_encounter en on po.PatientEncounterID=en.PatientEncounterID
left outer join patient_disposition pd on en.PatientDispositionID=pd.PatientDispositionId
left outer join encounter_diagnosis_free_text dt on po.PatientEncounterID=dt.PatientEncounterID
where po.OrderId=@OrderId and lr.PatientId=@PatientId and TakenDate between @StartDate and @EndDate
END