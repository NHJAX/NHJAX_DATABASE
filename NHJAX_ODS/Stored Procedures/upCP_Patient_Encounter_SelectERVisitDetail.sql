CREATE PROCEDURE [dbo].[upCP_Patient_Encounter_SelectERVisitDetail]
@pe bigint
WITH EXEC AS CALLER
AS
SELECT TOP (1) 
	PAT.PatientId, 
	PAT.FullName, 
	ISNULL(PAT.Phone, '--') AS Phone, 
	ISNULL(RIGHT(PAT.SSN, 4), 'UNK') AS LastFour,
	PAT.DOB,
	PAT.DisplayAge,
	PAT.Sex, 
	ENC.AppointmentDateTime, 
	PRO.ProviderName, 
	STAT.AppointmentStatusDesc, 
	PRI.PriorityDesc, 
	AC.ArrivalCategoryDesc, 
	DISP.PatientDispositionDesc, 
	ISNULL(RIGHT(PAT.SSN, 4), 'UNK') AS LastFour,  --PAT.SponsorSSN, 
	FMP.FamilyMemberPrefixCode, 
	RANK.MilitaryGradeRankDesc,
	DIAG.DiagnosisDesc, 
	ENDIAG.Priority,
	ISNULL(REAS.ReasonSeenDesc,'UNKNOWN') AS ReasonSeenDesc,
	ENC.EREntryNumber
FROM DIAGNOSIS AS DIAG 
	INNER JOIN	ENCOUNTER_DIAGNOSIS AS ENDIAG 
	ON DIAG.DiagnosisId = ENDIAG.DiagnosisId 
	RIGHT OUTER JOIN MILITARY_GRADE_RANK AS RANK 
	RIGHT OUTER JOIN PRIORITY AS PRI 
	INNER JOIN ARRIVAL_CATEGORY AS AC 
	INNER JOIN PATIENT_ENCOUNTER AS ENC 
	INNER JOIN PROVIDER AS PRO 
	ON ENC.ProviderId = PRO.ProviderId 
	ON AC.ArrivalCategoryId = ENC.ArrivalCategoryId		
	INNER JOIN PATIENT_DISPOSITION AS DISP 
	ON ENC.PatientDispositionId = DISP.PatientDispositionId 
	ON PRI.PriorityId = ENC.PriorityId 
	INNER JOIN FAMILY_MEMBER_PREFIX AS FMP 
	INNER JOIN PATIENT AS PAT 
	ON FMP.FamilyMemberPrefixId = PAT.FamilyMemberPrefixId 
	ON ENC.PatientId = PAT.PatientId 
	ON RANK.MilitaryGradeRankId = PAT.MilitaryGradeRankId 
	LEFT OUTER JOIN APPOINTMENT_STATUS AS STAT 
	ON ENC.AppointmentStatusId = STAT.AppointmentStatusId 
	ON ENDIAG.PatientEncounterId = ENC.PatientEncounterId
	LEFT OUTER JOIN REASON_SEEN AS REAS
	ON ENC.ReasonSeenId = REAS.ReasonSeenId
WHERE     (ENC.PatientEncounterId = @pe)