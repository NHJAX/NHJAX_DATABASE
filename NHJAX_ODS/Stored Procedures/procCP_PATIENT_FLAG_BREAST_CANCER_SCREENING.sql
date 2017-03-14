
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_BREAST_CANCER_SCREENING]

AS
BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @start datetime
	
	SET @start = dbo.StartofDay(DATEADD(M,-24,GETDATE()))
	
	INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
	SELECT 
		PatientId,
		7 AS FlagId,
		2 as SourceSystemId
	FROM PATIENT
	WHERE PatientID NOT IN
	(
		SELECT ENC.PatientId
		FROM PATIENT_ENCOUNTER AS ENC
			INNER JOIN PATIENT_PROCEDURE AS PPROC 
			ON ENC.PatientEncounterId = PPROC.PatientEncounterId
		WHERE (ENC.SourceSystemId = 6)
		AND (PPROC.CptID = 17811)
		AND	(ENC.AppointmentDateTime > @start)
		UNION
		------------MAMMOGRAM SCREENING RADIOLOGY CODE USED FOR 24 MOS------------
		SELECT DISTINCT	
			RE.PatientId
		FROM RADIOLOGY_EXAM AS RE 
			INNER JOIN RADIOLOGY AS RAD 
			ON RE.RadiologyId = RAD.RadiologyId  
		WHERE RAD.RadiologyCode = '3690'
			AND	RE.ExamDateTime >= @start
			AND	RE.PATIENTID IN 
			(
				SELECT PatientID 
				FROM PRIMARY_CARE_MANAGER
			)		
		UNION
		SELECT RE.PatientId
		FROM RADIOLOGY_EXAM AS RE
			INNER JOIN RADIOLOGY AS R
			ON R.RadiologyId = RE.RadiologyId
			INNER JOIN PATIENT_ENCOUNTER AS PE 
			ON RE.PATIENTID = PE.PATIENTID 
			INNER JOIN ENCOUNTER_DIAGNOSIS AS ED 
			ON PE.PATIENTENCOUNTERID = ED.PATIENTENCOUNTERID 
		WHERE R.CptId in 
			(
				7886,7887,7888,15776,18082,18083,18084,14417,14418,14419
			)
			AND RE.EXAMDATETIME > @start
			and RE.EXAMSTATUSID NOT IN (1,3,6,12)
			and ED.DiagnosisId not in
				(
					SELECT ICDId
					FROM FLAG_ICD
					WHERE FlagId = 7
				) --tests for death code
			AND PatientDeceased = 0
		UNION
		SELECT RE.PatientId
		FROM    RADIOLOGY_EXAM AS RE
			INNER JOIN RADIOLOGY AS R
			ON R.RadiologyId = RE.RadiologyId 
			INNER JOIN PATIENT AS P
			ON RE.PATIENTID = P.PatientId
		WHERE R.CptId IN 
			(
				1054,1058,1060,1062,17894,17895,17896,17897
			)
			AND RE.EXAMSTATUSID NOT IN (1,3,6,12)
		)		
		AND SEX = 'FEMALE'
		AND PatientAGE BETWEEN(42) AND (69)
		AND PatientCategoryID NOT IN 
		(
			SELECT PatientCategoryId
			 FROM PATIENT_CATEGORY
			 WHERE (PATIENTCATEGORYCODE LIKE '%00%')
			 OR (PatientCategoryCode LIKE '%45%') 
			 OR (PatientCategoryCode LIKE '%47%'))
		AND PatientId IN 
			(
				SELECT PatientId 
				FROM PRIMARY_CARE_MANAGER
			)
		
		AND PatientDeceased = 0
END
