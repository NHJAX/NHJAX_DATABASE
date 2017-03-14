
create PROCEDURE [dbo].[upEDPTS_GetChemistry20120815] 
(
	@PatientID	numeric,
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@OrderID	numeric
)
WITH RECOMPILE
AS
BEGIN
select lr.OrderId, lr.PatientId, p.PatientKey, p.FullName as PatientName, FamilyMemberPrefixCode as FMP, Right(SponsorSSN,4) as SSN, p.Phone,  
IsNull(loc.HospitalLocationName,'') as Clinic, IsNull(prov.ProviderName,'') as ProviderName, TakenDate, IsNull(CollectionSampleDesc,'') as Specimen,  
LabTestDesc, ChemistryResult, '' as ExamNumber, '' as ProcCode, IsNull(prov.DutyPhone,'') as DutyPhone, IsNull(prov.PagerNumber,'') as PagerNumber,
op.OrderPriorityDesc as Priority
from lab_result lr
left outer join patient p on lr.PatientId=p.PatientId
left outer join family_member_prefix f on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
left outer join lab_result_chemistry_result cr on lr.LabResultId=cr.LabResultId
left outer join lab_test t on cr.LabTestId=t.LabTestId
left outer join patient_order po on lr.OrderId=po.OrderId
left outer join hospital_location loc on po.LocationId=loc.HospitalLocationId
left outer join provider prov on po.OrderingProviderId=prov.ProviderId
left outer join collection_sample cs on po.CollectionSampleId=cs.CollectionSampleId
left outer join Order_Priority op on po.OrderPriorityID=op.OrderPriorityID
where po.OrderId=@OrderId and  po.PatientID=@PatientID and TakenDate between @StartDate and @EndDate
order by TakenDate
END
