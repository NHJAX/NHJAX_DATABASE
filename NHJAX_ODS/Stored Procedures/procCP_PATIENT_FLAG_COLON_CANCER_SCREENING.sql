
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_COLON_CANCER_SCREENING]

AS
BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @start datetime
	DECLARE @lstart datetime 
	DECLARE @mstart datetime
	
	SET @start = dbo.startofday(DATEADD(mm,-12,getdate()))
	SET @lstart = dbo.StartOfDay(DATEADD(mm,-120,getdate()))
	SET @mstart = dbo.StartOfDay(DATEADD(mm,-60,getdate()))
	
	DELETE FROM PATIENT_FLAG
	WHERE FlagId = 10;
		
	INSERT INTO PATIENT_FLAG
(
	PatientId,
	FlagId,
	SourceSystemId
)
SELECT 
	PatientId, 
	10 AS FlagId,
	2 AS SourceSystemId
FROM PATIENT
WHERE PatientId NOT IN
	(
		----------FECAL OCCULT BLOOD TEST SCREENING 12 MO-----------
		SELECT DISTINCT P.PatientId	
		FROM PATIENT_PROCEDURE PP 
			INNER JOIN PATIENT_ENCOUNTER PE 
			ON PP.PatientEncounterId = PE.PatientEncounterId 
			INNER JOIN PATIENT P 
			ON PE.PatientId = P.PatientId 
			INNER JOIN CPT C 
			ON C.CptId = PP.CptId				
		WHERE C.CptCode in 
			(
				'82270','82274','G0107','G0328','PHP3004'
			)			 
		AND PP.ProcedureDateTime >= @start	
		AND P.PATIENTID IN 
			(
				SELECT PATIENTID 
				FROM PRIMARY_CARE_MANAGER
			)	
		AND (year(GETDATE()) - year(p.dob)) BETWEEN 50 AND 80
		AND P.FullName NOT LIKE 'QQ%'
		AND P.FullName NOT LIKE 'zz%'
		AND PE.AppointmentStatusId = 2		
		UNION
		SELECT DISTINCT PatientId
		FROM LAB_RESULT LR 
			INNER JOIN LAB_TEST LT 
			ON LR.LabTestId = LT.LABTESTID  
		WHERE LR.LabTestid =3250
		AND LR.Result IS NOT NULL		
		AND LR.TAKENDATE  >= @start
		UNION
		------------colonoscopy within 120 MO
		SELECT DISTINCT	P.PatientId				  
		FROM PATIENT_PROCEDURE PP 
			INNER JOIN PATIENT_ENCOUNTER PE 
			ON PP.PatientEncounterId = PE.PatientEncounterId 
			INNER JOIN PATIENT P 
			ON PE.PatientId = P.PatientId 
			INNER JOIN CPT C 
			ON C.CptId = PP.CptId				
		WHERE C.CptCode IN 
			(
				'44388','44389','44390','44391','44392',
				'44393','44394','44397','45355','45378',
				'45379','45380','45381','45382','45383',
				'45384','45385','45385','45386','45387',
				'45391','45392','G0105','G0121','PHP3002'
			) 
			AND PP.ProcedureDateTime >= @lstart
			AND P.PATIENTID IN 
				(
					SELECT PATIENTID 
					FROM PRIMARY_CARE_MANAGER
				)
			AND (year(GETDATE()) - year(p.dob)) BETWEEN 50 AND 80		
			AND PE.AppointmentStatusId = 2
		UNION
		SELECT DISTINCT P.PatientId
		FROM PATIENT_ENCOUNTER as PE 
			INNER JOIN PATIENT as P 
			ON PE.PatientId = P.PatientId 
			INNER JOIN ENCOUNTER_DIAGNOSIS as ENCDIAG 
			ON PE.PatientEncounterId = ENCDIAG.PatientEncounterId          
		WHERE ENCDIAG.DiagnosisId IN 
			(
				SELECT ICDId
				FROM FLAG_ICD
				WHERE FlagId = 10
			)
			AND	ENCDIAG.CreatedDate >= @lstart
			AND (year(GETDATE()) - year(p.dob)) between 50 and 80
			AND p.fullname not like 'QQ%'
			AND p.fullname not like 'zz%'
			AND P.PATIENTID IN 
				(
					SELECT PATIENTID 
					FROM PRIMARY_CARE_MANAGER
				)	
			AND PE.AppointmentStatusId = 2	
		UNION
		------------CT COLONOGRAPHY------------------------------------
		SELECT DISTINCT RE.PATIENTID
		FROM RADIOLOGY_EXAM RE 
			INNER JOIN RADIOLOGY R	
			ON R.RadiologyId = RE.RadiologyId 
			INNER JOIN PATIENT_ENCOUNTER PE 
			ON RE.PATIENTID = PE.PATIENTID 
			INNER JOIN ENCOUNTER_DIAGNOSIS ED 
			ON PE.PATIENTENCOUNTERID = ED.PATIENTENCOUNTERID 
			INNER JOIN DIAGNOSIS DIAG 
			ON ED.DIAGNOSISID = DIAG.DIAGNOSISID 
			INNER JOIN CPT C 
			ON C.CptId = R.CptId 
			INNER JOIN PATIENT P 
			ON P.PatientId = PE.PatientId					
		WHERE C.CptCode in ('74263')
			AND RE.ExamDateTime >= @mstart
			AND P.PATIENTID IN (SELECT PATIENTID FROM PRIMARY_CARE_MANAGER)
			AND (year(GETDATE()) - year(p.dob)) BETWEEN 50 AND 80
			AND PE.AppointmentStatusId = 2
		UNION
		------------DOUBLE CONTRAST BARIUM ENEMA FOR 60 MOS-------------
		SELECT DISTINCT RE.PATIENTID
		FROM RADIOLOGY_EXAM RE 
			INNER JOIN RADIOLOGY R	
			ON R.RadiologyId = RE.RadiologyId 
			INNER JOIN PATIENT_ENCOUNTER PE 
			ON RE.PATIENTID = PE.PATIENTID 
			INNER JOIN ENCOUNTER_DIAGNOSIS ED 
			ON PE.PATIENTENCOUNTERID = ED.PATIENTENCOUNTERID  
			INNER JOIN CPT C 
			ON C.CptId = R.CptId 
			INNER JOIN PATIENT P 
			ON P.PatientId = PE.PatientId					
		WHERE C.CptCode in ('74280','PHP3005')
			AND RE.ExamDateTime >= @mstart
			AND P.PATIENTID IN (SELECT PATIENTID FROM PRIMARY_CARE_MANAGER)
			AND (year(GETDATE()) - year(p.dob)) BETWEEN 50 AND 80
			AND PE.AppointmentStatusId = 2		
		UNION
		------------DCBE RADIOLOGY CODE USED FOR 60 MOS------------
		SELECT DISTINCT	RE.PatientId            
		FROM RADIOLOGY_EXAM RE 
			INNER JOIN RADIOLOGY RAD 
			ON RE.RadiologyId = RAD.RadiologyId  
		WHERE RAD.RadiologyCode = '3050'
		AND RE.ExamDateTime >= @mstart
		AND RE.PATIENTID IN 
			(
				SELECT PATIENTID 
				FROM PRIMARY_CARE_MANAGER
			)
		UNION
		------------FLEXIBLE SIGMOIDOSCOPY FOR 60 MOS---------------
		SELECT DISTINCT P.PatientId 
		FROM PATIENT_PROCEDURE PP 
			INNER JOIN PATIENT_ENCOUNTER PE 
			ON PP.PatientEncounterId = PE.PatientEncounterId 
			INNER JOIN PATIENT P 
			ON PE.PatientId = P.PatientId 
			INNER JOIN CPT C 
			ON C.CptId = PP.CptId
		WHERE C.CptCode IN 
			(
				'45330','45331','45332','45333','45334','45335',
				'45337','45338','45338','45339','45340','45341',
				'45342','45345','PHP3003'
			)
			AND	PP.ProcedureDateTime >= @mstart	
			AND P.PATIENTID IN 
				(
					SELECT PATIENTID 
					FROM PRIMARY_CARE_MANAGER
				)
			AND PE.AppointmentStatusId = 2			
		
		UNION
		------------HAS COLORECTAL CANCER OR COLECTOMY---------------
		SELECT DISTINCT P.PatientId				  
		FROM PATIENT_PROCEDURE PP 
			INNER JOIN PATIENT_ENCOUNTER PE 
			ON PP.PatientEncounterId = PE.PatientEncounterId 
			INNER JOIN PATIENT P 
			ON PE.PatientId = P.PatientId 
			INNER JOIN CPT C 
			ON C.CptId = PP.CptId
		WHERE C.CptCode IN	
			(
				'44150','44151','44152','44153','44155',
				'44156','44210','44211','44212','G0213',
				'G0214','G0215','G0231'
			)	
			AND PE.AppointmentStatusId = 2	
		UNION
		SELECT P.PatientId
		FROM PATIENT_ENCOUNTER as PE 
			INNER JOIN PATIENT as P 
			ON PE.PatientId = P.PatientId 
			INNER JOIN ENCOUNTER_DIAGNOSIS as ENCDIAG 
			ON PE.PatientEncounterId = ENCDIAG.PatientEncounterId         
		WHERE ENCDIAG.DiagnosisId in 
			(
				SELECT ICDId 
				FROM FLAG_ICD
				WHERE FlagId = 10
			)	
			AND p.fullname not like 'QQ%'
			AND p.fullname not like 'zz%'
			AND PE.AppointmentStatusId = 2			
	)
	-------LOOKS FOR DEATH ICD-9 CODES
	
	AND PatientDeceased = 0	
	AND (year(GETDATE()) - year(dob)) BETWEEN 50 AND 80
	AND FullName NOT LIKE 'ZZ%'
	AND	FullName NOT LIKE 'QQ%'
	AND PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	AND FamilyMemberPrefixId NOT IN 
		(
			1,2,3,4,5,6,7,8,9,10,44,45,46,47,48,49,50,51,52
		)
END
