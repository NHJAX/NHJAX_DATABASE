
create PROCEDURE [dbo].[upEDPTS_GetXRay20120214] 
(
	@pat	numeric,
	@sdate	smalldatetime,
	@edate	smalldatetime,
	@ord	numeric
)
WITH RECOMPILE
AS
BEGIN
DECLARE @dDate smalldatetime
SET @dDate = DATEADD(dd, 2, dbo.EndofDay(@edate))

select distinct 
po.OrderId, 
po.PatientId, 
p.PatientKey, 
p.FullName as PatientName, 
FamilyMemberPrefixCode as FMP, 
Right(SponsorSSN,4) as SSN, 
p.Phone,  
IsNull(loc.HospitalLocationName,'') as Clinic, 
IsNull(prov.ProviderName,'') as ProviderName, 
e.ExamDateTime as TakenDate, 
'X-Ray' as Specimen,  
RadiologyDesc as LabTestDesc, 
DiagnosticCode, 
ResultCategoryDesc, 
ReportText, 
rr.ExamDateTime as ExamDateTime, 
e.ExamNumber, 
r.RadiologyCode as ProcCode, 
IsNull(prov.DutyPhone,'') as DutyPhone, 
IsNull(prov.PagerNumber,'') as PagerNumber, 
op.OrderPriorityDesc as Priority,
IsNull(PatientDispositionDesc,'') as Disposition,
IsNull(dt.DiagnosisFreeText, '') as DiagnosisFreeText
from patient_order po
left outer join patient p 
on po.PatientId=p.PatientId
left outer join family_member_prefix f 
on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
left outer join hospital_location loc 
on po.LocationId=loc.HospitalLocationId
left outer join provider prov 
on po.OrderingProviderId=prov.ProviderId
left outer join radiology_exam e 
on po.OrderId=e.OrderId
left outer join radiology r 
on e.RadiologyId=r.RadiologyId
left outer join radiology_report rr 
on p.PatientId=rr.PatientId
left outer join result_category rc 
on rr.ResultCategoryId=rc.ResultCategoryId
left outer join order_priority op 
on po.OrderPriorityID=op.OrderPriorityID
left outer join patient_encounter en 
on po.PatientEncounterID=en.PatientEncounterID
left outer join patient_disposition pd 
on en.PatientDispositionID=pd.PatientDispositionId
left outer join encounter_diagnosis_free_text dt 
on po.PatientEncounterID=dt.PatientEncounterID
where po.OrderId=@ord 
and po.PatientID=@pat
and e.ExamDateTime 
between dbo.StartofDay(@sdate) and dbo.EndofDay(@edate)
and rr.ExamDateTime 
between dbo.StartofDay(@sdate) and @dDate
and rr.ResultCategoryId <> 1 
END
