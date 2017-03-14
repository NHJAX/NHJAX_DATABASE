
CREATE PROCEDURE [dbo].[procCOPY_F_ED_ADMISSION]

AS

TRUNCATE TABLE ODS_COPY.dbo.F_ED_ADMISSION

DECLARE @sdate datetime
DECLARE @edate datetime

SET @sdate = dbo.StartOfDay('2014-01-01')
SET @edate = dbo.EndOfDay(GETDATE())

INSERT INTO ODS_COPY.dbo.F_ED_ADMISSION
(
	PatientId,
	FMP_SSN,
	PatientIdentifier,
	PatientAdmissionKey,
	AdmissionDateTime,
	DischargeDateTime,
	TypeofDisposition,
	AttendingPhysician,
	WardLocation,
	DiagnosisAtAdmission,
	EncounterKey,
	AdmissionOrderKey,
	DispositionOrderKey
)
SELECT 
	PATIENT.PatientId,
	FMP.FamilyMemberPrefixCode + '/' + PATIENT.SponsorSSN,
	PATIENT.PatientIdentifier,
	PA.PatientAdmissionKey,
	PA.AdmissionDate,
	PA.DischargeDate,
	DIS.DischargeTypeDesc,
	PROVIDER.ProviderName,
	LOC.HospitalLocationName,
	DIAG.DiagnosisDesc,
	PA.EncounterKey,
	PA.AdmissionOrderKey,
	PA.DispositionOrder
FROM PATIENT_ADMISSION AS PA
INNER JOIN PATIENT
ON PA.PatientId = PATIENT.PatientId
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP
ON PATIENT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
INNER JOIN DISCHARGE_TYPE AS DIS
ON DIS.DischargeTypeId = PA.DischargeTypeId
LEFT OUTER JOIN PROVIDER
ON PROVIDER.ProviderId = PA.AttendingPhysicianId  
LEFT OUTER JOIN HOSPITAL_LOCATION AS LOC
ON PA.HospitalLocationId = LOC.HospitalLocationId
INNER JOIN DIAGNOSIS AS DIAG
ON PA.DiagnosisAtAdmissionId = DIAG.DiagnosisId
AND DIAG.DiagnosisType = 0
WHERE PA.PatientId IN (SELECT PatientId FROM ODS_COPY.dbo.B_ED_PATIENT)
AND PA.AdmissionDate BETWEEN @sdate AND @edate