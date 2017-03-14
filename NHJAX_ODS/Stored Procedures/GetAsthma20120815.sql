CREATE PROCEDURE [dbo].[GetAsthma20120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@SortBy	int=0
)
WITH RECOMPILE
AS
If @SortBy = 1   /* sort by Patient, Date */
BEGIN
select DiagnosisCode, DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, 
FullName as PatientName, SponsorSSN, DisplayAge as Age, AppointmentDateTime, provider.ProviderName, 
hospital_location.HospitalLocationName as Location, Drug.DrugDesc, provider.ProviderID, AppointmentStatusDesc as Type, 
0 as PreviousVisits, '' as Allergies, '' as OrderingHCP, ''as OrderDateTime, '' as oLocation, '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin
FROM encounter_diagnosis 
left outer join patient_encounter on encounter_diagnosis.patientencounterid=patient_encounter.patientencounterid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient_order on patient_encounter.patientencounterid=patient_order.patientencounterid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosistype=0 and (diagnosiscode like '493.0%' or diagnosiscode like '493.1%')
and appointmentdatetime between @StartDate and @EndDate
order by patient.FullName, patient_encounter.AppointmentDateTime
END
else if @SortBy = 2 	/* sort by Provider, Date */
BEGIN
select DiagnosisCode, DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, 
FullName as PatientName, SponsorSSN, DisplayAge as Age, AppointmentDateTime, provider.ProviderName, 
hospital_location.HospitalLocationName as Location, Drug.DrugDesc, provider.ProviderID, AppointmentStatusDesc as Type, 
0 as PreviousVisits, '' as Allergies, '' as OrderingHCP, ''as OrderDateTime, '' as oLocation, '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin
FROM encounter_diagnosis 
left outer join patient_encounter on encounter_diagnosis.patientencounterid=patient_encounter.patientencounterid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient_order on patient_encounter.patientencounterid=patient_order.patientencounterid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosistype=0 and (diagnosiscode like '493.0%' or diagnosiscode like '493.1%')
and appointmentdatetime between @StartDate and @EndDate
order by provider.ProviderName, patient_encounter.AppointmentDateTime
END
else	/* sort by Date */
BEGIN
select DiagnosisCode, DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, 
FullName as PatientName, SponsorSSN, DisplayAge as Age, AppointmentDateTime, provider.ProviderName, 
hospital_location.HospitalLocationName as Location, Drug.DrugDesc, provider.ProviderID, AppointmentStatusDesc as Type, 
0 as PreviousVisits, '' as Allergies, '' as OrderingHCP, ''as OrderDateTime, '' as oLocation, '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin
FROM encounter_diagnosis 
left outer join patient_encounter on encounter_diagnosis.patientencounterid=patient_encounter.patientencounterid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient_order on patient_encounter.patientencounterid=patient_order.patientencounterid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosistype=0 and (diagnosiscode like '493.0%' or diagnosiscode like '493.1%')
and appointmentdatetime between @StartDate and @EndDate
order by patient_encounter.AppointmentDateTime, patient.FullName
END