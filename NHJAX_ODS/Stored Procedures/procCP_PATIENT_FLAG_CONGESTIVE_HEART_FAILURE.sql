﻿
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_CONGESTIVE_HEART_FAILURE]

AS
BEGIN	
	SET NOCOUNT ON;
	INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)

	SELECT DISTINCT PE.PatientId, 
		11 AS FlagId,
		2 AS SourceSystemId
	FROM PATIENT_ENCOUNTER AS PE 
		LEFT JOIN ENCOUNTER_DIAGNOSIS AS ED 
		ON PE.PatientEncounterId = ED.PatientEncounterId 
		LEFT JOIN PATIENT P 
		ON P.PATIENTID = PE.PATIENTID	
	WHERE (ED.DiagnosisId IN
		(
			SELECT ICDId
			FROM FLAG_ICD
			WHERE FlagId = 11
		)) 
	AND (PE.AppointmentDateTime > dateadd(mm, -12, getdate()))
	AND P.PatientCategoryID NOT IN 
		(
			SELECT PATIENTCATEGORYID
			FROM PATIENT_CATEGORY
			WHERE (PATIENTCATEGORYCODE LIKE '%00%')
			OR (PatientCategoryCode LIKE '%45%') 
			OR (PatientCategoryCode LIKE '%47%')
		)

	AND P.PatientDeceased = 0
	AND		P.PATIENTID IN 
		(
			SELECT PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)

	AND P.PatientDeceased = 0
	UNION
	SELECT DISTINCT P.PatientId,
		11 AS FlagId, 
		6 AS SourceSystemId
	FROM vwMDE_PATIENT AS PAT 
		INNER JOIN vwSTG_POP_HEALTH_CHF AS CHF
		ON PAT.PATIENT_IDENTIFIER = CHF.EDIPN 
		INNER JOIN PATIENT P
		ON PAT.KEY_PATIENT = P.PatientKey
	WHERE P.PatientCategoryID NOT IN 
		(
			SELECT		PATIENTCATEGORYID
			FROM		PATIENT_CATEGORY
			WHERE		((PatientCategoryCode LIKE '%45%') 
						OR (PatientCategoryCode LIKE '%47%'))
		)

	AND P.PatientDeceased = 0
END
