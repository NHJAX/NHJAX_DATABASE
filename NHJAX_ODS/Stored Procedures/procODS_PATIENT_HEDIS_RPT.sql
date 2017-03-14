CREATE PROCEDURE [dbo].[procODS_PATIENT_HEDIS_RPT]
	@HospitalLocation int=0
WITH EXEC AS CALLER
AS

SELECT   P.PatientId
		,FMP.FamilyMemberPrefixCode + '/' + SUBSTRING(P.SponsorSSN,8,4) as FMP_SSN
        ,P.FullName
        ,P.Sex
        ,P.DisplayAge
        ,PC.PatientCategoryDesc
        ,PatD.FacilityName as PatientsDMIS
        ,PRO.ProviderName
        ,PcmD.FacilityName as PCMsDMIS
        ,HL.HospitalLocationId
        ,HL.HospitalLocationName
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,1) = 1 THEN 'Yes' ELSE 'No' END as Asthamatic
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,2) = 1 THEN 'Yes' ELSE 'No' END as Diabetic
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,3) = 1 THEN 'Yes' ELSE 'No' END as Hyperlipidemic
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,4) = 1 THEN 'Yes' ELSE 'No' END as Walking
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,5) = 1 THEN 'Yes' ELSE 'No' END as BackPainAcute
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,6) = 1 THEN 'Yes' ELSE 'No' END as BackPainRecurrent
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,7) = 1 THEN 'Yes' ELSE 'No' END as BreastCancerScreening
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,8) = 1 THEN 'Yes' ELSE 'No' END as CardioRisk
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,9) = 1 THEN 'Yes' ELSE 'No' END as CervicalCancerScreening
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,10) = 1 THEN 'Yes' ELSE 'No' END as ColonCancerScreening
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,11) = 1 THEN 'Yes' ELSE 'No' END as CongestiveHeartFailure
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,12) = 1 THEN 'Yes' ELSE 'No' END as COPD
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,13) = 1 THEN 'Yes' ELSE 'No' END as Depression
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,14) = 1 THEN 'Yes' ELSE 'No' END as Hypertension
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,15) = 1 THEN 'Yes' ELSE 'No' END as LipidPanel
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,16) = 1 THEN 'Yes' ELSE 'No' END as TobaccoCessation
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,17) = 1 THEN 'Yes' ELSE 'No' END as Maternity
        ,CASE WHEN dbo.PatientHasHedisFlag(P.PatientId,18) = 1 THEN 'Yes' ELSE 'No' END as BMI 
FROM PATIENT AS P
  INNER JOIN PATIENT_CATEGORY AS PC ON PC.PatientCategoryId = P.PatientCategoryId
  INNER JOIN DMIS AS PatD ON PatD.DMISId = P.DMISId
  INNER JOIN PRIMARY_CARE_MANAGER AS PCM ON PCM.PatientID = P.PatientId
  INNER JOIN DMIS AS PcmD ON PcmD.DMISId = PCM.DmisId
  INNER JOIN PROVIDER AS PRO ON PRO.ProviderId = PCM.ProviderId
  INNER JOIN FAMILY_MEMBER_PREFIX AS FMP ON FMP.FamilyMemberPrefixId = P.FamilyMemberPrefixId
  INNER JOIN [HOSPITAL_LOCATION] as HL ON HL.HospitalLocationId = PCM.HospitalLocationId
	AND HL.HospitalLocationId = CASE WHEN @HospitalLocation = 0 THEN HL.HospitalLocationId ELSE @HospitalLocation END


