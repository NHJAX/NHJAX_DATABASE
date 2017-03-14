
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_TOBACCO_CESSATION]

AS
BEGIN	
	SET NOCOUNT ON;
	DECLARE @patientid bigint
			,@patientid2 bigint
			,@res nvarchar(10)
			,@pe bigint

	DECLARE CURTC CURSOR FAST_FORWARD FOR
	SELECT DISTINCT		
			PE.Patientid
	FROM	VITAL V INNER JOIN 
			PATIENT_ENCOUNTER PE ON V.PatientEncounterId = PE.PatientEncounterId INNER JOIN 
			PATIENT P ON P.PatientId = PE.PatientId
	WHERE	V.VitalTypeId = 1
	AND		V.Result = 'Y'
	-------LOOKS FOR DEATH ICD-9 CODES
	AND		P.STATEID IN (119,133)
	AND	PE.AppointmentDateTime > DATEADD(m,-12,GETDATE())
	
	AND P.PatientDeceased = 0
	AND P.FullName NOT LIKE 'ZZ%'
	AND P.FullName NOT LIKE 'QQ%'
	AND P.PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	AND P.FamilyMemberPrefixId NOT IN 
		(
			1,2,3,4,5,6,7,8,9,10,44,45,46,47,48,49,50,51,52
		)

OPEN CURTC
FETCH NEXT FROM CURTC INTO @patientid
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @@FETCH_STATUS = 0
				BEGIN
					SELECT TOP 1 @patientid2 = PE.PatientId
								 ,@res = v.result							
					FROM	[NHJAX_ODS].dbo.VITAL V INNER JOIN
							[NHJAX_ODS].dbo.PATIENT_ENCOUNTER PE ON PE.PatientEncounterId = V.PatientEncounterId
					WHERE	PE.PatientId = @patientid
					AND		V.VitalTypeId = 1
					ORDER BY PE.AppointmentDateTime DESC						
					
					IF (@res = 'Y')
						BEGIN
							BEGIN TRANSACTION
								INSERT INTO [NHJAX_ODS].dbo.PATIENT_FLAG
									(
										PatientId
										,FlagId
										,SourceSystemId
										
									)
								VALUES
									(
										@patientid2
										,16
										,11										
									);
							COMMIT
						END
						FETCH NEXT FROM CURTC INTO @patientid
						
				END
		END		
CLOSE CURTC
DEALLOCATE CURTC
--20120516 Add other tobacco flags
INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
--20120516 Add Diagnosis Codes (305.1,V151.82)
SELECT  DISTINCT   ENC.PatientId,
	16 AS FlagId,
	2 AS SourceSystemId
FROM  ENCOUNTER_DIAGNOSIS AS ED 
	INNER JOIN PATIENT_ENCOUNTER AS ENC 
	ON ED.PatientEncounterId = ENC.PatientEncounterId
	INNER JOIN PATIENT P 
	ON P.PatientId = ENC.PatientId
WHERE     (ED.DiagnosisId IN 
	(
		SELECT ICDId
		FROM FLAG_ICD
		WHERE FlagId = 16
	))
	-------LOOKS FOR DEATH ICD-9 CODES
	AND		P.STATEID IN (119,133)
	AND	ENC.AppointmentDateTime > DATEADD(m,-12,GETDATE())
	--AND	P.PatientId NOT IN
	--	(
	--		SELECT PE.PatientId
	--		FROM ENCOUNTER_DIAGNOSIS ED 
	--			INNER JOIN PATIENT_ENCOUNTER PE 
	--			ON PE.PatientEncounterId = ED.PatientEncounterId 
	--			INNER JOIN DIAGNOSIS D 
	--			ON D.DiagnosisId = ED.DiagnosisId
	--		WHERE D.DiagnosisCode IN
	--			(
	--				'798.1','798.9','798.0','798.2'
	--			)			
	--	)
	AND P.PatientDeceased = 0
	AND P.PatientId NOT IN
		(
			SELECT PatientId
			FROM PATIENT_FLAG
			WHERE FlagId = 16
		)
	AND P.FullName NOT LIKE 'ZZ%'
	AND P.FullName NOT LIKE 'QQ%'
	AND P.PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	AND P.FamilyMemberPrefixId NOT IN 
		(
			1,2,3,4,5,6,7,8,9,10,44,45,46,47,48,49,50,51,52
		)
--20120516 Add CPT Codes (G0436, G0437,99406,99407,96153)
UNION 	SELECT  DISTINCT   ENC.PatientId,
	16 AS FlagId,
	2 AS SourceSystemId
FROM  PATIENT_PROCEDURE AS PP 
	INNER JOIN PATIENT_ENCOUNTER AS ENC 
	ON PP.PatientEncounterId = ENC.PatientEncounterId
	INNER JOIN PATIENT P 
	ON P.PatientId = ENC.PatientId
WHERE     (PP.CptId IN (20443, 20444, 14218, 18977, 18978))
	-------LOOKS FOR DEATH ICD-9 CODES
	AND		P.STATEID IN (119,133)
	AND	ENC.AppointmentDateTime > DATEADD(m,-12,GETDATE())
	
	AND P.PatientDeceased = 0
	AND P.PatientId NOT IN
		(
			SELECT PatientId
			FROM PATIENT_FLAG
			WHERE FlagId = 16
		)
	AND P.FullName NOT LIKE 'ZZ%'
	AND P.FullName NOT LIKE 'QQ%'
	AND P.PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	AND P.FamilyMemberPrefixId NOT IN 
		(
			1,2,3,4,5,6,7,8,9,10,44,45,46,47,48,49,50,51,52
		)
--20120516 Add Ancillary Procedure Codes (Tob Cess)
UNION 	SELECT  DISTINCT   ORD.PatientId,
	16 AS FlagId,
	2 AS SourceSystemId
FROM  PATIENT_ORDER AS ORD 
	INNER JOIN PATIENT P 
	ON P.PatientId = ORD.PatientId
WHERE     (ORD.AncillaryProcedureId IN (1505, 1506, 1593, 1597, 1614, 1621, 1624, 1625, 1639, 1801, 5281)) 
	-------LOOKS FOR DEATH ICD-9 CODES
	AND		P.STATEID IN (119,133)
	AND	ORD.OrderDateTime > DATEADD(m,-12,GETDATE())
	
	AND P.PatientDeceased = 0
	AND P.PatientId NOT IN
		(
			SELECT PatientId
			FROM PATIENT_FLAG
			WHERE FlagId = 16
		)
	AND P.FullName NOT LIKE 'ZZ%'
	AND P.FullName NOT LIKE 'QQ%'
	AND P.PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	AND P.FamilyMemberPrefixId NOT IN 
		(
			1,2,3,4,5,6,7,8,9,10,44,45,46,47,48,49,50,51,52
		)

--20150409 Add Essentris Tobacco Use
UNION SELECT DISTINCT P.PatientId,
	16 AS FlagId,
	16 AS SourceSystemId
FROM PATIENT AS P
	INNER JOIN [NHJAX-CACHE].STAGING.dbo.ESS_TOBACCO_USE AS TU
	ON P.PatientKey = TU.PatientKey
WHERE TU.Tobacco = 'Active'
	AND TU.KeyDate > DATEADD(m,-12,GETDATE())
	AND P.PatientDeceased = 0
	AND P.PatientId NOT IN
		(
			SELECT PatientId
			FROM PATIENT_FLAG
			WHERE FlagId = 16
		)
	AND P.FullName NOT LIKE 'ZZ%'
	AND P.FullName NOT LIKE 'QQ%'
	AND P.PATIENTID IN 
		(
			SELECT PRIMARY_CARE_MANAGER.PATIENTID 
			FROM PRIMARY_CARE_MANAGER
		)
	AND P.FamilyMemberPrefixId NOT IN 
		(
			1,2,3,4,5,6,7,8,9,10,44,45,46,47,48,49,50,51,52
		)

END
