
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_CERVICAL_CANCER_SCREENING]

AS
BEGIN	
	SET NOCOUNT ON;
	--//***********************************************************
	--* 9-3-2013 added V88.01 Diagnosis code for Hysterectomy. REE
	--* LINE # 143
	--//***********************************************************
	DECLARE @PapDate datetime
	DECLARE @PapFromDate Datetime
	DECLARE @yr int
	SET @PapDate = DATEADD(m,-36,getdate());
	SET @PapfromDate = dbo.StartOfDay(@papDate);
	SET @yr = year(GETDATE())
	
	INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
	SELECT DISTINCT	
		P.PatientId, 
		9 AS FlagId,
		2 AS SourceSystemId
	FROM PATIENT AS P
	WHERE (@yr - year(p.dob)) between 24 and 64
		AND p.fullname not like 'QQ%'
		AND p.fullname not like 'zz%'
		AND P.PATIENTID IN (SELECT PATIENTID FROM PRIMARY_CARE_MANAGER)
		AND P.Sex = 'female'
		AND P.FamilyMemberPrefixId NOT IN 
		(
			44,45,46,47,48,49,50,51,52
		)
		AND P.PatientId NOT IN
		(
			------------- HAD CERVICAL CANCER SCREENING - SOURCE CHCS
			SELECT DISTINCT P.PatientId
			FROM PATIENT_ENCOUNTER AS PE 
				INNER JOIN PATIENT AS P 
				ON PE.PatientId = P.PatientId 
				INNER JOIN PATIENT_PROCEDURE AS PP 
				ON PE.PatientEncounterId = PP.PatientEncounterId 
				INNER JOIN CPT 
				ON CPT.cptid = PP.cptid 
			WHERE (CPT.Cptcode IN 
				(
					'88141','88142','88143','88147','88148','88150',
					'88152','88153','88154','88155','88164',
					'88165','88166','88167','88174','88175','q0091',
					'g0101','g0123','g0124','g0141','g0142','g0143',
					'g0144','g0145','g0147','g0148','php3000','php3001')
				)
				AND (PP.ProcedureDateTime > @PapFromDate)
				AND (@yr - year(p.dob)) between 24 and 64
				AND p.fullname not like 'QQ%'
				AND p.fullname not like 'zz%'
				AND P.PATIENTID IN 
					(
						SELECT PatientId FROM PRIMARY_CARE_MANAGER
					)
				AND PE.AppointmentStatusId = 2
			UNION
			SELECT DISTINCT PE.PatientId
			FROM PATIENT_PROCEDURE AS PP 
				INNER JOIN CPT 
				ON PP.CptId = CPT.CptId 
				INNER JOIN PATIENT_ENCOUNTER PE 
				ON PE.PatientEncounterId = PP.PatientEncounterId
			WHERE CPT.CptCode = 'Q0091'
				AND	PP.ProcedureDateTime >= @PapFromDate
				AND PE.AppointmentStatusId = 2

			UNION
			SELECT DISTINCT P.PatientId
			FROM PATIENT_ENCOUNTER as PE 
				INNER JOIN PATIENT as P 
				ON PE.PatientId = P.PatientId 
				INNER JOIN ENCOUNTER_DIAGNOSIS as ENCDIAG
				ON PE.PatientEncounterId = ENCDIAG.PatientEncounterId       
			WHERE (ENCDIAG.DiagnosisId in 
					(
						SELECT ICDId 
						FROM FLAG_ICD
						WHERE FlagId = 9
					))
				AND (PE.AppointmentDateTime > @PapFromDate)
				AND (@yr - year(p.dob)) between 24 and 64
				AND p.fullname not like 'QQ%'
				AND p.fullname not like 'zz%'
				AND	P.PATIENTID IN 
					(
						SELECT PatientId 
						FROM PRIMARY_CARE_MANAGER
					)
				AND PE.AppointmentStatusId = 2

			UNION -- -----------hysterectomy performed or no residual cervix-----------
			SELECT DISTINCT P.PatientId
			FROM PATIENT_ENCOUNTER as PE 
				INNER JOIN PATIENT as P 
				ON PE.PatientId = P.PatientId 
				INNER JOIN PATIENT_PROCEDURE as PP 
				ON PE.PatientEncounterId = PP.PatientEncounterId 
				inner join CPT on CPT.cptid = PP.cptid 
			WHERE (CPT.Cptcode IN 
				(
					'51925','56308','58150','58152','58200','58210',
					'58240','58260','58262','58263','58267','58270',
					'58275','58280','58285','58290','58291','58292',
					'58293','58294','58544','58550','58551','58552',
					'58553','58554','58951','58953','58954','58956',
					'59135'
				))
				AND	(@yr - year(p.dob)) between 24 and 64
				AND	p.fullname not like 'QQ%'
				AND	p.fullname not like 'zz%'
				AND	P.PATIENTID IN 
					(
						SELECT PatientId 
						FROM PRIMARY_CARE_MANAGER
					)
				AND	PE.AppointmentStatusId = 2

			UNION -- -----------hysterectomy performed or no residual cervix-----------
			SELECT DISTINCT P.PatientId
			FROM PATIENT_ENCOUNTER as PE 
				INNER JOIN PATIENT as P 
				ON PE.PatientId = P.PatientId 
				INNER JOIN ENCOUNTER_DIAGNOSIS as ENCDIAG 
				ON PE.PatientEncounterId = ENCDIAG.PatientEncounterId          
			WHERE (ENCDIAG.DiagnosisId in 
				(
					SELECT ICDId 
					FROM FLAG_ICD
					WHERE FlagId = 9
				))
				AND PE.AppointmentStatusId = 2
		) ---------end not in nested select---------------
		
		AND P.PatientDeceased = 0
END
