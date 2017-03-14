CREATE PROCEDURE [dbo].[GetAccessToCare20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@Dept		numeric
)
WITH RECOMPILE
AS
If @Dept = 0 
BEGIN
SELECT e.HospitalLocationId, h.HospitalLocationName, e.PatientId, p.BenefitsCategoryId, BenefitsCategoryDesc, AccessToCareDate, DateAppointmentMade, AppointmentDateTime, e.AccessToCareId ,
AccessToCareDesc as Category, AccessToCareStandard as Standard,
CASE AccessToCareDate
	WHEN AccessToCareDate then DateDiff(d, AccessToCareDate, AppointmentDateTime)
	ELSE DateDiff(d, DateAppointmentMade, AppointmentDateTime)
END as Days, e.ReferralId, r.RefusalReasonId
from patient_encounter e
left outer join Patient p on e.PatientId=p.PatientId
left outer join Hospital_Location h on e.HospitalLocationId=h.HospitalLocationId
left outer join Benefits_Category b on p.BenefitsCategoryId=b.BenefitsCategoryId
left outer join Access_To_Care c on e.AccessToCareId=c.AccessToCareId
left outer join Referral_Refusal r on e.ReferralId=r.ReferralId
where appointmentdatetime between @StartDate and @EndDate and 
e.accesstocareid is not null 
END
else
BEGIN
SELECT e.HospitalLocationId, h.HospitalLocationName, e.PatientId, p.BenefitsCategoryId, BenefitsCategoryDesc, AccessToCareDate, DateAppointmentMade, AppointmentDateTime, e.AccessToCareId ,
AccessToCareDesc as Category, AccessToCareStandard as Standard,
CASE AccessToCareDate
	WHEN AccessToCareDate then DateDiff(d, AccessToCareDate, AppointmentDateTime)
	ELSE DateDiff(d, DateAppointmentMade, AppointmentDateTime)
END as Days, e.ReferralId, r.RefusalReasonId
from patient_encounter e
left outer join Patient p on e.PatientId=p.PatientId
left outer join Hospital_Location h on e.HospitalLocationId=h.HospitalLocationId
left outer join Benefits_Category b on p.BenefitsCategoryId=b.BenefitsCategoryId
left outer join Access_To_Care c on e.AccessToCareId=c.AccessToCareId
left outer join Referral_Refusal r on e.ReferralId=r.ReferralId
where appointmentdatetime between @StartDate and @EndDate and 
e.accesstocareid is not null and
h.HospitalLocationKey=@Dept
END