CREATE PROCEDURE [dbo].[GetDiabetesDx20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@SortBy	int=0
)
WITH RECOMPILE
AS
If @SortBy = 1   /* sort by Patient, Date */
BEGIN
select diagnosis.DiagnosisCode, diagnosis.DiagnosisName, patient_encounter.PatientID, 
patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, DisplayAge as Age, 
Patient_encounter.AppointmentDateTime, provider.ProviderName, hospital_location.HospitalLocationName as Location, 
provider.ProviderID, Appointment_Status.AppointmentStatusDesc as Type, 0 as PreviousVisits, '' as Allergies, '' as OrderingHCP, ''as OrderDateTime, '' as oLocation, '' as DrugDesc,
'' as Triglyceride,
isnull((select top 1 lab_result.result from lab_result 
 where lab_result.LabTestID=657 and lab_result.patientid=patient.patientid 
 and lab_result.TakenDate >= DATEADD(d, -365, Patient_encounter.appointmentdatetime)
 order by lab_result.TakenDate DESC),'NO TEST') as Cholesterol, /*LDL Cholesterol */
isnull((select top 1 lab_result.result from lab_result 
 where lab_result.LabTestID=1894 and lab_result.patientid=patient.patientid 
 and lab_result.TakenDate >= DATEADD(d, -365, Patient_encounter.appointmentdatetime)
 order by lab_result.TakenDate DESC),'NO TEST') as Hemoglobin /*Hemoglobin A1C */
FROM patient_encounter
left outer join encounter_diagnosis on patient_encounter.patientencounterid=encounter_diagnosis.patientencounterid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosis.diagnosistype=0 and diagnosis.diagnosiscode like '250.%'
and Patient_encounter.appointmentdatetime >= @StartDate and Patient_encounter.appointmentdatetime <= @EndDate
order by patient.FullName, patient_encounter.AppointmentDateTime
END
else if @SortBy = 2 	/* sort by Provider, Date */
BEGIN
select diagnosis.DiagnosisCode, diagnosis.DiagnosisName, patient_encounter.PatientID, 
patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, DisplayAge as Age, 
Patient_encounter.AppointmentDateTime, provider.ProviderName, hospital_location.HospitalLocationName as Location, 
provider.ProviderID, Appointment_Status.AppointmentStatusDesc as Type, 0 as PreviousVisits, '' as Allergies, '' as OrderingHCP, ''as OrderDateTime, '' as oLocation, '' as DrugDesc,
'' as Triglyceride,
isnull((select top 1 lab_result.result from lab_result 
 where lab_result.LabTestID=657 and lab_result.patientid=patient.patientid 
 and lab_result.TakenDate >= DATEADD(d, -365, Patient_encounter.appointmentdatetime)
 order by lab_result.TakenDate DESC),'NO TEST') as Cholesterol, /*LDL Cholesterol */
isnull((select top 1 lab_result.result from lab_result 
 where lab_result.LabTestID=1894 and lab_result.patientid=patient.patientid 
 and lab_result.TakenDate >= DATEADD(d, -365, Patient_encounter.appointmentdatetime)
 order by lab_result.TakenDate DESC),'NO TEST') as Hemoglobin /*Hemoglobin A1C */
FROM patient_encounter
left outer join encounter_diagnosis on patient_encounter.patientencounterid=encounter_diagnosis.patientencounterid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosis.diagnosistype=0 and diagnosis.diagnosiscode like '250.%'
and Patient_encounter.appointmentdatetime >= @StartDate and Patient_encounter.appointmentdatetime <= @EndDate
order by provider.ProviderName, patient_encounter.AppointmentDateTime
END
else	/* sort by Date */
BEGIN
select diagnosis.DiagnosisCode, diagnosis.DiagnosisName, patient_encounter.PatientID, 
patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, DisplayAge as Age, 
Patient_encounter.AppointmentDateTime, provider.ProviderName, hospital_location.HospitalLocationName as Location, 
provider.ProviderID, Appointment_Status.AppointmentStatusDesc as Type, 0 as PreviousVisits, '' as Allergies, '' as OrderingHCP, ''as OrderDateTime, '' as oLocation, '' as DrugDesc,
'' as Triglyceride,
isnull((select top 1 lab_result.result from lab_result 
 where lab_result.LabTestID=657 and lab_result.patientid=patient.patientid 
 and lab_result.TakenDate >= DATEADD(d, -365, Patient_encounter.appointmentdatetime)
 order by lab_result.TakenDate DESC),'NO TEST') as Cholesterol, /*LDL Cholesterol */
isnull((select top 1 lab_result.result from lab_result 
 where lab_result.LabTestID=1894 and lab_result.patientid=patient.patientid 
 and lab_result.TakenDate >= DATEADD(d, -365, Patient_encounter.appointmentdatetime)
 order by lab_result.TakenDate DESC),'NO TEST') as Hemoglobin /*Hemoglobin A1C */
FROM patient_encounter
left outer join encounter_diagnosis on patient_encounter.patientencounterid=encounter_diagnosis.patientencounterid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosis.diagnosistype=0 and diagnosis.diagnosiscode like '250.%'
and Patient_encounter.appointmentdatetime >= @StartDate and Patient_encounter.appointmentdatetime <= @EndDate
order by patient_encounter.AppointmentDateTime
END