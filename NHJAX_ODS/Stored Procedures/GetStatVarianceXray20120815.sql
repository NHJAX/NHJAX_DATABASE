CREATE PROCEDURE [dbo].[GetStatVarianceXray20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime
)
WITH RECOMPILE
AS
BEGIN
/* X-Ray */
select distinct po.OrderId, po.PatientId, p.FullName as PatientName, FamilyMemberPrefixCode as FMP, Right(SponsorSSN,4) as SSN, 
IsNull(loc.HospitalLocationName,'') as Clinic, IsNull(prov.ProviderName,'') as ProviderName, 
e.ExamDateTime as TakenDate, 'X-Ray' as Source, '' as GramStain, '' as BacteriologyResult, 
RadiologyDesc as LabTestDesc, RadiologyDesc  as Organism, '' as Medication, '' as Treated, '' as Certified, '' as Comments, 'X-Ray' as Type,
IsNull(FollowUpComplete,0) as FollowUpComplete
from patient_order po
left outer join order_type ot on po.OrderTypeId=ot.OrderTypeId
left outer join patient p on po.PatientId=p.PatientId
left outer join family_member_prefix f on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
left outer join radiology_exam e on po.OrderId=e.OrderId
left outer join radiology r on e.RadiologyId=r.RadiologyId
left outer join radiology_report rr on p.PatientId=rr.PatientId
left outer join result_category rc on rr.ResultCategoryId=rc.ResultCategoryId
left outer join hospital_location loc on po.LocationId=loc.HospitalLocationId
left outer join provider prov on po.OrderingProviderId=prov.ProviderId
left outer join CDSS2.dbo.ER_FollowUp u ON po.PatientID=u.PatientID AND po.OrderID=u.OrderID
where (po.LocationId=174 or po.LocationId=17) and ot.OrderTypeDesc='RAD' 
and e.ExamDateTime between @StartDate and @EndDate
and rr.ExamDateTime between @StartDate and @EndDate
and rr.ResultCategoryId <> 1 
order by TakenDate
END