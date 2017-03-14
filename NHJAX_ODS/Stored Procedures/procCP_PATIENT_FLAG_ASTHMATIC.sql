
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_ASTHMATIC]

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
		1 AS FlagId,
		2 AS SourceSystemId
	FROM PATIENT_ENCOUNTER AS PE 
		INNER JOIN ENCOUNTER_DIAGNOSIS AS ED 
		ON PE.PatientEncounterId = ED.PatientEncounterId 
		INNER JOIN PATIENT P 
		ON P.PATIENTID = PE.PATIENTID	
	WHERE (ED.DiagnosisId IN 
		(
			--'493%'
			SELECT ICDId
			FROM FLAG_ICD
			WHERE FlagId = 1
		)) 
	--AND (DIAG.DiagnosisCode <> '493.2')
	 
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
	--and diag.diagnosiscode not in
	--	(
	--		'761.6','768.1','798.1','798.9','798.0','798.2'
	--	)
	AND		P.PATIENTID IN 
		(
			SELECT PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	--and	p.patientid  not in 
	--	(
	--		select pe.patientid 
	--		from encounter_diagnosis ed		
	--			inner join patient_encounter pe
	--			on pe.patientencounterid = ed.patientencounterid 
	--		where diagnosisid in (4341,4342,6515,9830)
	--	)
	UNION
	SELECT P.PatientId,
		1 AS FlagId, 
		6 AS SourceSystemId
	FROM vwMDE_PATIENT AS PAT  
		INNER JOIN vwSTG_POP_HEALTH_ASTHMA AS ASTH 
		ON PAT.PATIENT_IDENTIFIER = ASTH.EDIPN 
		INNER JOIN PATIENT P
		ON PAT.KEY_PATIENT = P.PatientKey
	WHERE P.PatientCategoryID NOT IN 
		(
			SELECT PATIENTCATEGORYID
			FROM PATIENT_CATEGORY
			WHERE (PatientCategoryCode LIKE '%45%'
		) 
		OR (PatientCategoryCode LIKE '%47%')) 
		--and	p.patientid  not in 
		--(
		--	select pe.patientid 
		--	from encounter_diagnosis ed 
		--		inner join patient_encounter pe
		--		on pe.patientencounterid = ed.patientencounterid 
		--		where diagnosisid in (4341,4342,6515,9830)
		--)
		AND P.PatientDeceased = 0
END
