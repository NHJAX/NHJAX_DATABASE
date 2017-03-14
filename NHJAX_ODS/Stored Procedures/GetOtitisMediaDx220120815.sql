CREATE PROCEDURE [dbo].[GetOtitisMediaDx220120815] 
(
	@StartDate	smalldatetime,
	@EndDate	smalldatetime,
	@SortBy	int=0
)
WITH RECOMPILE
AS
If @SortBy = 1   /* sort by Patient, Date */
BEGIN
select distinct DiagnosisCode, DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, SponsorSSN, DisplayAge as Age, AppointmentDateTime, 
provider.ProviderName, hospital_location.HospitalLocationName as Location, Drug.DrugDesc, IsNull(AllergyDesc,'') as Allergies, provider.ProviderID,  oprovider.ProviderName as OrderingHCP, patient_order.OrderDateTime,  '' as Type, '' as oLocation,
(select count(*) from patient_encounter pe
left outer join encounter_diagnosis ed on pe.patientencounterid=ed.patientencounterid
left outer join diagnosis d on ed.diagnosisid=d.diagnosisid
where d.diagnosistype=0 and d.diagnosiscode in ('381.01', '381.4', '381.00', '381.04', '381.05', '381.02') 
and pe.patientid = patient_encounter.PatientID 
and pe.appointmentdatetime >= DATEADD(d, -15, patient_encounter.appointmentdatetime) 
and pe.appointmentdatetime < patient_encounter.appointmentdatetime) as PreviousVisits, '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin 
FROM encounter_diagnosis 
left outer join patient_encounter on encounter_diagnosis.patientencounterid=patient_encounter.patientencounterid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient_order on patient_encounter.patientencounterid=patient_order.patientencounterid
left outer join provider oprovider on patient_order.OrderingProviderID=oprovider.providerid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join Patient_Allergy on patient_encounter.patientID = Patient_Allergy.PatientID
left outer join Allergy on patient_allergy.AllergyID = Allergy.AllergyID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosistype=0 and diagnosiscode in ('381.01', '381.4', '381.00', '381.04', '381.05', '381.02') 
and patientage < 18
and appointmentdatetime >= @StartDate and appointmentdatetime <= @EndDate
order by patient.FullName, patient_encounter.AppointmentDateTime
END

else if @SortBy = 2	/* sort by Provider, Date */
BEGIN
select distinct DiagnosisCode, DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, SponsorSSN, DisplayAge as Age, AppointmentDateTime, 
provider.ProviderName, hospital_location.HospitalLocationName as Location, Drug.DrugDesc, IsNull(AllergyDesc,'') as Allergies, provider.ProviderID, oprovider.ProviderName as OrderingHCP, patient_order.OrderDateTime,  '' as Type, '' as oLocation,
(select count(*) from patient_encounter pe
left outer join encounter_diagnosis ed on pe.patientencounterid=ed.patientencounterid
left outer join diagnosis d on ed.diagnosisid=d.diagnosisid
where d.diagnosistype=0 and d.diagnosiscode in ('381.01', '381.4', '381.00', '381.04', '381.05', '381.02') 
and pe.patientid = patient_encounter.PatientID 
and pe.appointmentdatetime >= DATEADD(d, -15, patient_encounter.appointmentdatetime) 
and pe.appointmentdatetime < patient_encounter.appointmentdatetime) as PreviousVisits, '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin 
FROM encounter_diagnosis 
left outer join patient_encounter on encounter_diagnosis.patientencounterid=patient_encounter.patientencounterid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient_order on patient_encounter.patientencounterid=patient_order.patientencounterid
left outer join provider oprovider on patient_order.OrderingProviderID=oprovider.providerid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join Patient_Allergy on patient_encounter.patientID = Patient_Allergy.PatientIDleft outer join Allergy on patient_allergy.AllergyID = Allergy.AllergyID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosistype=0 and diagnosiscode in ('381.01', '381.4', '381.00', '381.04', '381.05', '381.02') 
and patientage < 18
and appointmentdatetime >= @StartDate and appointmentdatetime <= @EndDate
order by Provider.ProviderName, patient_encounter.AppointmentDateTime, patient_encounter.PatientEncounterID
END

else	/* sort by Date */
BEGIN
select distinct DiagnosisCode, DiagnosisName, patient_encounter.PatientID, patient.PatientKey, patient_encounter.PatientEncounterID, FullName as PatientName, SponsorSSN, DisplayAge as Age, AppointmentDateTime, 
provider.ProviderName, hospital_location.HospitalLocationName as Location, Drug.DrugDesc, IsNull(AllergyDesc,'') as Allergies, provider.ProviderID, oprovider.ProviderName as OrderingHCP, patient_order.OrderDateTime, '' as Type, '' as oLocation,
(select count(*) from patient_encounter pe
left outer join encounter_diagnosis ed on pe.patientencounterid=ed.patientencounterid
left outer join diagnosis d on ed.diagnosisid=d.diagnosisid
where d.diagnosistype=0 and d.diagnosiscode in ('381.01', '381.4', '381.00', '381.04', '381.05', '381.02') 
and pe.patientid = patient_encounter.PatientID 
and pe.appointmentdatetime >= DATEADD(d, -15, patient_encounter.appointmentdatetime) 
and pe.appointmentdatetime < patient_encounter.appointmentdatetime) as PreviousVisits, '' as Triglyceride, '' as Cholesterol, '' as Hemoglobin 
FROM encounter_diagnosis 
left outer join patient_encounter on encounter_diagnosis.patientencounterid=patient_encounter.patientencounterid
left outer join patient on patient_encounter.patientid=patient.patientid
left outer join provider on patient_encounter.providerid=provider.providerid
left outer join hospital_location on patient_encounter.hospitallocationid = hospital_location.hospitallocationid
left outer join diagnosis on encounter_diagnosis.diagnosisid=diagnosis.diagnosisid
left outer join patient_order on patient_encounter.patientencounterid=patient_order.patientencounterid
left outer join provider oprovider on patient_order.OrderingProviderID=oprovider.providerid
left outer join prescription on patient_order.OrderID = prescription.OrderID
left outer join drug on prescription.DrugID = drug.DrugID
left outer join Patient_Allergy on patient_encounter.patientID = Patient_Allergy.PatientID
left outer join Allergy on patient_allergy.AllergyID = Allergy.AllergyID
left outer join Appointment_Status on patient_encounter.appointmentstatusid=Appointment_Status.AppointmentStatusID
where diagnosistype=0 and diagnosiscode in ('381.01', '381.4', '381.00', '381.04', '381.05', '381.02') 
and patientage < 18
and appointmentdatetime >= @StartDate and appointmentdatetime <= @EndDate
order by appointmentdatetime, patient_encounter.PatientEncounterID
END