-- =============================================
-- Author:		Robert Evans
-- Create date: 24 Mar 2015
-- Description:	Gets TBI Patients by Alpha
-- =============================================
CREATE PROCEDURE procODS_TBI_PATIENTS_SelectByAlpha
	@AlphabeticNumber int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @AlphabeticLikeString NVARCHAR(2) 

	If @AlphabeticNumber = 0
		BEGIN
			SELECT P.[PatientId]
				  ,P.[FullName]
				  ,P.[Sex]
				  ,CONVERT(NVARCHAR(15),P.[DOB],101) as DOB
				  ,P.[SSN]
				  ,P.[StreetAddress1]
				  ,P.[StreetAddress2]
				  ,P.[City]
				  ,GL.[GeographicLocationAbbrev]
				  ,P.[ZipCode]
				  ,P.[Phone]
				  ,P.[OfficePhone]
				  ,BOS.[BranchofServiceDesc]
				  ,P.[SponsorSSN]
				  ,P.[FamilyMemberPrefixId]
				  ,MGR.[MilitaryGradeRankAbbrev]
				  ,P.[DMISId]
				  --,P.[CurrentPCMId]
				  ,PRO.[ProviderName]
				  ,R.[RaceDesc]
				  ,P.[PatientAge]
				  ,MS.[MaritalStatusDesc]
				  ,P.[ODSLName]
				  ,P.[ODSFName]
				  ,P.[ODSMName]
				  ,P.[DisplayAge]
				  ,CASE WHEN P.[ActiveDuty] = 0 THEN 'No'
					WHEN P.[ActiveDuty] = 1 THEN 'Yes'
					ELSE 'Unknown' END as ActiveDuty
				  ,P.[PatientIdentifier]
			  FROM [NHJAX_ODS].[dbo].[PATIENT] as P
			INNER JOIN [NHJAX_ODS].[dbo].[RACE] as R ON P.RaceId = R.RaceId
			INNER JOIN [NHJAX_ODS].[dbo].[MARITAL_STATUS] as MS ON MS.[MaritalStatusId] = P.[MaritalStatusId]
			LEFT JOIN [NHJAX_ODS].[dbo].[GEOGRAPHIC_LOCATION] as GL ON GL.[GeographicLocationId] = P.[StateId]
			LEFT JOIN [NHJAX_ODS].[dbo].[BRANCH_OF_SERVICE] as BOS ON BOS.[BranchofServiceId] = P.[LastBranchOfServiceId]
			LEFT JOIN [NHJAX_ODS].[dbo].[MILITARY_GRADE_RANK] as MGR ON MGR.[MilitaryGradeRankId] = P.[MilitaryGradeRankId]
			LEFT JOIN [NHJAX_ODS].[dbo].[PROVIDER] as PRO ON PRO.[ProviderId] = P.[CurrentPCMId]
			WHERE P.[PatientDeceased] = 0 
			AND P.[PatientId] IN (SELECT DISTINCT PE.[PatientId]
								FROM [CLINICAL_PORTAL].[dbo].[vwODS_ENCOUNTER_DIAGNOSIS] as ED
									INNER JOIN [CLINICAL_PORTAL].[dbo].[vwODS_PATIENT_ENCOUNTER] as PE
									ON PE.[PatientEncounterId] = ED.[PatientEncounterId] 
									AND DiagnosisId IN (SELECT [DiagnosisId]
														FROM [NHJAX_ODS].[dbo].[DIAGNOSIS]
														WHERE DiagnosisCode IN ('850.11','780.93')
														OR DiagnosisCode LIKE 'V15.52 2'
														OR DiagnosisCode LIKE 'V70.5 6%'
														OR DiagnosisCode LIKE 'V80.01%'
														)
							   )
			ORDER BY P.[ODSLName], P.[ODSFName], P.[ODSMName]
		END
	ELSE
		BEGIN

			IF @AlphabeticNumber = 1 SET @AlphabeticLikeString = 'A%'
			IF @AlphabeticNumber = 2 SET @AlphabeticLikeString = 'B%'
			IF @AlphabeticNumber = 3 SET @AlphabeticLikeString = 'C%'
			IF @AlphabeticNumber = 4 SET @AlphabeticLikeString = 'D%'
			IF @AlphabeticNumber = 5 SET @AlphabeticLikeString = 'E%'
			IF @AlphabeticNumber = 6 SET @AlphabeticLikeString = 'F%'
			IF @AlphabeticNumber = 7 SET @AlphabeticLikeString = 'G%'
			IF @AlphabeticNumber = 8 SET @AlphabeticLikeString = 'H%'
			IF @AlphabeticNumber = 9 SET @AlphabeticLikeString = 'I%'
			IF @AlphabeticNumber = 10 SET @AlphabeticLikeString = 'J%'
			IF @AlphabeticNumber = 11 SET @AlphabeticLikeString = 'K%'
			IF @AlphabeticNumber = 12 SET @AlphabeticLikeString = 'L%'
			IF @AlphabeticNumber = 13 SET @AlphabeticLikeString = 'M%'
			IF @AlphabeticNumber = 14 SET @AlphabeticLikeString = 'N%'
			IF @AlphabeticNumber = 15 SET @AlphabeticLikeString = 'O%'
			IF @AlphabeticNumber = 16 SET @AlphabeticLikeString = 'P%'
			IF @AlphabeticNumber = 17 SET @AlphabeticLikeString = 'Q%'
			IF @AlphabeticNumber = 18 SET @AlphabeticLikeString = 'R%'
			IF @AlphabeticNumber = 19 SET @AlphabeticLikeString = 'S%'
			IF @AlphabeticNumber = 20 SET @AlphabeticLikeString = 'T%'
			IF @AlphabeticNumber = 21 SET @AlphabeticLikeString = 'U%'
			IF @AlphabeticNumber = 22 SET @AlphabeticLikeString = 'V%'
			IF @AlphabeticNumber = 23 SET @AlphabeticLikeString = 'W%'
			IF @AlphabeticNumber = 24 SET @AlphabeticLikeString = 'X%'
			IF @AlphabeticNumber = 25 SET @AlphabeticLikeString = 'Y%'
			IF @AlphabeticNumber = 26 SET @AlphabeticLikeString = 'Z%'

			SELECT P.[PatientId]
				  ,P.[FullName]
				  ,P.[Sex]
				  ,CONVERT(NVARCHAR(15),P.[DOB],101) as DOB
				  ,P.[SSN]
				  ,P.[StreetAddress1]
				  ,P.[StreetAddress2]
				  ,P.[City]
				  ,GL.[GeographicLocationAbbrev]
				  ,P.[ZipCode]
				  ,P.[Phone]
				  ,P.[OfficePhone]
				  ,BOS.[BranchofServiceDesc]
				  ,P.[SponsorSSN]
				  ,P.[FamilyMemberPrefixId]
				  ,MGR.[MilitaryGradeRankAbbrev]
				  ,P.[DMISId]
				  --,P.[CurrentPCMId]
				  ,PRO.[ProviderName]
				  ,R.[RaceDesc]
				  ,P.[PatientAge]
				  ,MS.[MaritalStatusDesc]
				  ,P.[ODSLName]
				  ,P.[ODSFName]
				  ,P.[ODSMName]
				  ,P.[DisplayAge]
				  ,CASE WHEN P.[ActiveDuty] = 0 THEN 'No'
					WHEN P.[ActiveDuty] = 1 THEN 'Yes'
					ELSE 'Unknown' END as ActiveDuty
				  ,P.[PatientIdentifier]
			  FROM [NHJAX_ODS].[dbo].[PATIENT] as P
			INNER JOIN [NHJAX_ODS].[dbo].[RACE] as R ON P.RaceId = R.RaceId
			INNER JOIN [NHJAX_ODS].[dbo].[MARITAL_STATUS] as MS ON MS.[MaritalStatusId] = P.[MaritalStatusId]
			LEFT JOIN [NHJAX_ODS].[dbo].[GEOGRAPHIC_LOCATION] as GL ON GL.[GeographicLocationId] = P.[StateId]
			LEFT JOIN [NHJAX_ODS].[dbo].[BRANCH_OF_SERVICE] as BOS ON BOS.[BranchofServiceId] = P.[LastBranchOfServiceId]
			LEFT JOIN [NHJAX_ODS].[dbo].[MILITARY_GRADE_RANK] as MGR ON MGR.[MilitaryGradeRankId] = P.[MilitaryGradeRankId]
			LEFT JOIN [NHJAX_ODS].[dbo].[PROVIDER] as PRO ON PRO.[ProviderId] = P.[CurrentPCMId]
			WHERE P.[PatientDeceased] = 0
			AND P.[ODSLName] LIKE @AlphabeticLikeString
			AND P.[PatientId] IN (SELECT DISTINCT PE.[PatientId]
								FROM [CLINICAL_PORTAL].[dbo].[vwODS_ENCOUNTER_DIAGNOSIS] as ED
									INNER JOIN [CLINICAL_PORTAL].[dbo].[vwODS_PATIENT_ENCOUNTER] as PE
									ON PE.[PatientEncounterId] = ED.[PatientEncounterId] 
									AND DiagnosisId IN (SELECT [DiagnosisId]
														FROM [NHJAX_ODS].[dbo].[DIAGNOSIS]
														WHERE DiagnosisCode IN ('850.11','780.93')
														OR DiagnosisCode LIKE 'V15.52 2'
														OR DiagnosisCode LIKE 'V70.5 6%'
														OR DiagnosisCode LIKE 'V80.01%'
														)
							   )
			ORDER BY P.[ODSLName], P.[ODSFName], P.[ODSMName]
		END
END
