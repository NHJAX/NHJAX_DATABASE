
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_ANTIDEPRESSANT]

AS
BEGIN	
	SET NOCOUNT ON;
	DECLARE @fromDate datetime
	DECLARE @tempDate datetime
	SET @tempDate = DATEADD(m,-24,getdate());
	SET @fromDate = dbo.StartOfDay(@tempDate);
	INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
	SELECT PE.PatientId, 
		19 AS FlagId,
		2 AS SourceSystemId
	FROM PATIENT_ENCOUNTER AS PE 
		INNER JOIN ENCOUNTER_DIAGNOSIS AS ED 
		ON PE.PatientEncounterId = ED.PatientEncounterId 
		INNER JOIN PATIENT P 
		ON P.PATIENTID = PE.PATIENTID	
	WHERE (ED.DiagnosisId IN 
		(
			SELECT ICDId 
			FROM FLAG_ICD
			WHERE FlagId = 19
		)) 
	AND (PE.AppointmentDateTime > @fromDate)
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

	UNION
	SELECT P.PatientId,
		19 AS FlagId, 
		6 AS SourceSystemId
	FROM vwMDE_PATIENT AS PAT  
		INNER JOIN vwSTG_POP_HEALTH_ANTIDEPRESSANT AS ANTI 
		ON PAT.PATIENT_IDENTIFIER = ANTI.EDIPN 
		INNER JOIN PATIENT P
		ON PAT.KEY_PATIENT = P.PatientKey
	WHERE P.PatientCategoryID NOT IN 
		(
			SELECT PATIENTCATEGORYID
			FROM PATIENT_CATEGORY
			WHERE (PatientCategoryCode LIKE '%45%'
		) 
		OR (PatientCategoryCode LIKE '%47%')) 
		AND P.PatientDeceased = 0
END
