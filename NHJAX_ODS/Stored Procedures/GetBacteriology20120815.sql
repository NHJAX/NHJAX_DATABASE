CREATE PROCEDURE [dbo].[GetBacteriology20120815] 
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
GramStain, BacteriologyResult, LabTestDesc, EtiologyDesc as Organism, AntibioticSusceptibilityDesc as Antibiotic,
Sensitivity, LabInterpretationCode as Interpretation, '' as ExamNumber, '' as ProcCode, IsNull(prov.DutyPhone,'') as DutyPhone, 
IsNull(prov.PagerNumber, '') as PagerNumber, op.OrderPriorityDesc as Priority
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
left outer join lab_result_antibiotic a on o.LabResultOrganismId=a.LabResultOrganismId
left outer join lab_interpretation i on a.LabInterpretationId=i.LabInterpretationId
left outer join antibiotic_susceptibility s on a.AntibioticSusceptibilityId=s.AntibioticSusceptibilityId
left outer join order_priority op on po.OrderPriorityID=op.OrderPriorityID
where po.OrderId=@OrderId and lr.PatientId=@PatientId and TakenDate between @StartDate and @EndDate
END