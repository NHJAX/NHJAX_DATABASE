
CREATE PROCEDURE [dbo].[procEDPTS_PATIENT_ENCOUNTER_SelectAsthmaVisits]
(
	@sdate datetime,
	@edate datetime
)
AS
	SET NOCOUNT ON;
	
SELECT DISTINCT 
	PAT.FullName, 
	ENC.EREntryNumber, 
	STAT.AppointmentStatusDesc,   
	ENC.AppointmentDateTime,  
	FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN, 4) 
	AS SponsorSSN, 
	PAT.DisplayAge, 
	LOC.HospitalLocationName, 
	DI.DiagnosisCode, 
	DI.DiagnosisDesc,
	DI.DiagnosisName,
	DI.DiagnosisCode + ' (' + DI.DiagnosisDesc + ')' AS Diagnosis,
	ISNULL(PRO.ProviderId,0) AS ProviderId,
	ISNULL(PRO.ProviderName,'') AS ProviderName,
	ISNULL(PLOC.HospitalLocationDesc,'') AS HomePort,
	ENC.PatientId
FROM PATIENT_ENCOUNTER AS ENC 
	INNER JOIN PATIENT AS PAT 
	ON ENC.PatientId = PAT.PatientId 
	INNER JOIN FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
	INNER JOIN HOSPITAL_LOCATION AS LOC 
	ON PAT.RecordLocationId = LOC.HospitalLocationId 
	INNER JOIN ENCOUNTER_DIAGNOSIS AS DIAG 
	ON ENC.PatientEncounterId = DIAG.PatientEncounterId
	INNER JOIN DIAGNOSIS AS DI
	ON DI.DiagnosisId = DIAG.DiagnosisId
	LEFT OUTER JOIN PRIMARY_CARE_MANAGER AS PCM
	ON ENC.PatientId = PCM.PatientID
	LEFT OUTER JOIN PROVIDER AS PRO
	ON PCM.ProviderId = PRO.ProviderId
	INNER JOIN APPOINTMENT_STATUS AS STAT
	ON ENC.AppointmentStatusId = STAT.AppointmentStatusId
	LEFT OUTER JOIN HOSPITAL_LOCATION AS PLOC
	ON PRO.LocationId = PLOC.HospitalLocationId
WHERE (ENC.HospitalLocationId = 174) 
	AND (ENC.AppointmentDateTime 
		BETWEEN dbo.StartOfDay(@sdate) 
		AND dbo.EndOfDay(@edate)) 
	AND (DIAG.DiagnosisId IN 
		(
			6227,11374,13822,2738,15261,6243,13861,13817,6241,2690
		))
ORDER BY DI.DiagnosisCode, ENC.EREntryNumber;

