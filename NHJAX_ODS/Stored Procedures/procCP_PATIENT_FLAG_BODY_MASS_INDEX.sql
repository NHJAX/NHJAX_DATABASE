
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_BODY_MASS_INDEX]

AS
BEGIN	
	SET NOCOUNT ON;
	INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
	SELECT	DISTINCT 
		PE.PatientId,
		18 AS FlagId,
		11 as SourceSystemId
	FROM VITAL V 
		INNER JOIN PATIENT_ENCOUNTER PE 
		ON V.PatientEncounterId = PE.PatientEncounterId 
		INNER JOIN PATIENT P 
		ON P.PatientId = PE.PatientId
	WHERE V.VitalTypeId = 2
		AND PE.AppointmentDateTime > DATEADD(m,-12,GETDATE())
		-------LOOKS FOR DEATH ICD-9 CODES

		AND P.PatientDeceased = 0
		AND P.FullName NOT LIKE 'ZZ%'
		AND P.FullName NOT LIKE 'QQ%'
		AND P.PATIENTID IN 
			(
				SELECT PRIMARY_CARE_MANAGER.PATIENTID 
				FROM PRIMARY_CARE_MANAGER
			)
		AND CAST(V.Result AS float) >= 30
--20120516 Add users from CHCS data

--20120516 Diagnosis Codes (278.X)
INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
SELECT	DISTINCT 
		ENC.PatientId,
		18 AS FlagId,
		2 as SourceSystemId
	FROM  ENCOUNTER_DIAGNOSIS AS ED 
	INNER JOIN PATIENT_ENCOUNTER AS ENC 
	ON ED.PatientEncounterId = ENC.PatientEncounterId
	INNER JOIN PATIENT P 
	ON P.PatientId = ENC.PatientId
WHERE (ED.DiagnosisId IN 
	(
		SELECT ICDId 
		FROM FLAG_ICD
		WHERE FlagId = 18
	))
		AND ENC.AppointmentDateTime > DATEADD(m,-12,GETDATE())
		
		AND P.PatientDeceased = 0
		AND P.PatientId NOT IN
		(
			SELECT PatientId
			FROM PATIENT_FLAG
			WHERE FlagId = 18
		)
		AND P.FullName NOT LIKE 'ZZ%'
		AND P.FullName NOT LIKE 'QQ%'
		AND P.PATIENTID IN 
			(
				SELECT PRIMARY_CARE_MANAGER.PATIENTID 
				FROM PRIMARY_CARE_MANAGER
			)
--Ancillary Procedures
UNION
SELECT  DISTINCT   ORD.PatientId,
	18 AS FlagId,
	2 AS SourceSystemId
FROM  PATIENT_ORDER AS ORD 
	INNER JOIN PATIENT P 
	ON P.PatientId = ORD.PatientId
WHERE     (ORD.AncillaryProcedureId IN (5112,5113,1780,5110,5114,5115)) 
	-------LOOKS FOR DEATH ICD-9 CODES
	AND		P.STATEID IN (119,133)
	AND	ORD.OrderDateTime > DATEADD(m,-12,GETDATE())
	
	AND P.PatientDeceased = 0
	AND P.PatientId NOT IN
		(
			SELECT PatientId
			FROM PATIENT_FLAG
			WHERE FlagId = 18
		)
	AND P.FullName NOT LIKE 'ZZ%'
	AND P.FullName NOT LIKE 'QQ%'
	AND P.PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
END
