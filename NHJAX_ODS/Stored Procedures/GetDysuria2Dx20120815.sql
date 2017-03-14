CREATE PROCEDURE [dbo].[GetDysuria2Dx20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@SortBy	int=0
)
WITH RECOMPILE
AS
If @SortBy = 1   /* sort by Patient, Date */
BEGIN
select distinct diagnosis.DiagnosisCode, diagnosis.DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, DisplayAge as Age, Patient_encounter.AppointmentDateTime, 
provider.ProviderName, hospital_location.HospitalLocationName as Location, 
DrugDesc =
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN Drug.DrugDesc
 ELSE ''
END,
OrderDateTime = 
CASE 
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN patient_order.OrderDateTime
 ELSE null
END,
IsNull(AllergyDesc,'') as Allergies, provider.ProviderID, 
OrderingHCP = 
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN oprovider.ProviderName
 ELSE ''
END,
Appointment_Status.AppointmentStatusDesc as Type, 0 as PreviousVisits, 
oLocation = 
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN oloc.HospitalLocationName
 ELSE ''
END,
'' as Triglyceride, '' as Cholesterol, '' as Hemoglobin 
FROM patient_encounter
left outer join encounter_diagnosis on patient_encounter.patientencounterid=encounter_diagnosis.patientencounterid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join Patient_Allergy on patient_encounter.patientID = Patient_Allergy.PatientID
left outer join Allergy on patient_allergy.AllergyID = Allergy.AllergyID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
left outer join patient_order on patient_encounter.patientid=patient_order.patientid
left outer join provider oprovider on patient_order.OrderingProviderID=oprovider.providerid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join hospital_location oloc on patient_order.locationid=oloc.hospitallocationid
where diagnosis.diagnosistype=0 and diagnosis.diagnosiscode in ('791.9', '599.0', '788.1', '595.0', '535.0', '595.9')
and patientage >= 18
and Patient_encounter.appointmentdatetime between @StartDate and @EndDate
and patient_order.OrderTypeID = 16 
and Patient_encounter.PatientEncounterID not in 
(select ped.patientencounterid  from patient_encounter ped
 left outer join patient p on ped.patientid=p.patientid
 left outer join encounter_diagnosis edd on ped.patientencounterid=edd.patientencounterid
 left outer join diagnosis dd on edd.diagnosisid=dd.diagnosisid 
 where dd.diagnosiscode like '601%'
	or dd.diagnosiscode like '098%'
	or dd.diagnosiscode like '099%'
	or dd.diagnosiscode like '594%'
	or dd.diagnosiscode like '590%'
	or dd.diagnosiscode like '592%'
	or dd.diagnosiscode like '646.6%'
	or dd.diagnosiscode like '597.80%'
	and appointmentdatetime between @StartDate and @EndDate)
order by patient.FullName, patient_encounter.AppointmentDateTime, patient_order.OrderDateTime
END

else if @SortBy = 2 	/* sort by Provider, Date */
BEGIN
select distinct diagnosis.DiagnosisCode, diagnosis.DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, DisplayAge as Age, Patient_encounter.AppointmentDateTime, 
provider.ProviderName, hospital_location.HospitalLocationName as Location, 
DrugDesc =
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN Drug.DrugDesc
 ELSE ''
END,
OrderDateTime = 
CASE 
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN patient_order.OrderDateTime
 ELSE null
END,
IsNull(AllergyDesc,'') as Allergies, provider.ProviderID, 
OrderingHCP = 
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN oprovider.ProviderName
 ELSE ''
END,
Appointment_Status.AppointmentStatusDesc as Type, 0 as PreviousVisits, 
oLocation = 
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN oloc.HospitalLocationName
 ELSE ''
END,
 '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin 
FROM patient_encounter
left outer join encounter_diagnosis on patient_encounter.patientencounterid=encounter_diagnosis.patientencounterid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join Patient_Allergy on patient_encounter.patientID = Patient_Allergy.PatientID
left outer join Allergy on patient_allergy.AllergyID = Allergy.AllergyID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
left outer join patient_order on patient_encounter.patientid=patient_order.patientid
left outer join provider oprovider on patient_order.OrderingProviderID=oprovider.providerid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join hospital_location oloc on patient_order.locationid=oloc.hospitallocationid
where diagnosis.diagnosistype=0 and diagnosis.diagnosiscode in ('791.9', '599.0', '788.1', '595.0', '535.0', '595.9')
and patientage >= 18
and Patient_encounter.appointmentdatetime between @StartDate and @EndDate
and patient_order.OrderTypeID = 16 
and Patient_encounter.PatientEncounterID not in 
(select ped.patientencounterid  from patient_encounter ped
 left outer join patient p on ped.patientid=p.patientid
 left outer join encounter_diagnosis edd on ped.patientencounterid=edd.patientencounterid
 left outer join diagnosis dd on edd.diagnosisid=dd.diagnosisid 
 where dd.diagnosiscode like '601%'
	or dd.diagnosiscode like '098%'
	or dd.diagnosiscode like '099%'
	or dd.diagnosiscode like '594%'
	or dd.diagnosiscode like '590%'
	or dd.diagnosiscode like '592%'
	or dd.diagnosiscode like '646.6%'
	or dd.diagnosiscode like '597.80%'
	and appointmentdatetime between @StartDate and @EndDate)
order by provider.ProviderName, patient_encounter.AppointmentDateTime, patient_encounter.PatientEncounterID, patient_order.OrderDateTime
END

else	/* sort by Date */
BEGIN
select distinct diagnosis.DiagnosisCode, diagnosis.DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, DisplayAge as Age, Patient_encounter.AppointmentDateTime, 
provider.ProviderName, hospital_location.HospitalLocationName as Location, 
DrugDesc =
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN Drug.DrugDesc
 ELSE ''
END,
OrderDateTime = 
CASE 
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN patient_order.OrderDateTime
 ELSE null
END,
IsNull(AllergyDesc,'') as Allergies, provider.ProviderID, 
OrderingHCP = 
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN oprovider.ProviderName
 ELSE ''
END,
Appointment_Status.AppointmentStatusDesc as Type, 0 as PreviousVisits, 
oLocation = 
CASE
 WHEN patient_order.OrderDateTime between patient_encounter.appointmentdatetime and DATEADD(d, 5, Patient_encounter.appointmentdatetime) THEN oloc.HospitalLocationName
 ELSE ''
END,
 '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin 
FROM patient_encounter
left outer join encounter_diagnosis on patient_encounter.patientencounterid=encounter_diagnosis.patientencounterid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join Patient_Allergy on patient_encounter.patientID = Patient_Allergy.PatientID
left outer join Allergy on patient_allergy.AllergyID = Allergy.AllergyID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
left outer join patient_order on patient_encounter.patientid=patient_order.patientid
left outer join provider oprovider on patient_order.OrderingProviderID=oprovider.providerid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join hospital_location oloc on patient_order.locationid=oloc.hospitallocationid
where diagnosis.diagnosistype=0 and diagnosis.diagnosiscode in ('791.9', '599.0', '788.1', '595.0', '535.0', '595.9')
and patientage >= 18
and Patient_encounter.appointmentdatetime between @StartDate and @EndDate
and patient_order.OrderTypeID = 16 
and Patient_encounter.PatientEncounterID not in 
(select ped.patientencounterid  from patient_encounter ped
 left outer join patient p on ped.patientid=p.patientid
 left outer join encounter_diagnosis edd on ped.patientencounterid=edd.patientencounterid
 left outer join diagnosis dd on edd.diagnosisid=dd.diagnosisid 
 where dd.diagnosiscode like '601%'
	or dd.diagnosiscode like '098%'
	or dd.diagnosiscode like '099%'
	or dd.diagnosiscode like '594%'
	or dd.diagnosiscode like '590%'
	or dd.diagnosiscode like '592%'
	or dd.diagnosiscode like '646.6%'
	or dd.diagnosiscode like '597.80%'
	and appointmentdatetime between @StartDate and @EndDate)
order by Patient_encounter.appointmentdatetime, patient_encounter.PatientEncounterID, patient_order.OrderDateTime

END