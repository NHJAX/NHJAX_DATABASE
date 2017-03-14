
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectActivebyMonth_20091130]
(
	@mth int = 0
)
AS
	SET NOCOUNT ON;
		
IF @mth = 0
BEGIN
SELECT     
	MPAT.MaternityPatientId, 
	MPAT.PatientId,
	PAT.FullName, 
	FMP.FamilyMemberPrefixCode, 
	PAT.SponsorSSN, 
	PAT.DOB, 
	PAT.StreetAddress1, 
	PAT.StreetAddress2, 
	PAT.StreetAddress3, 
	PAT.City, 
	PAT.ZipCode, 
	LOC.GeographicLocationAbbrev, 
	PAT.Phone, 
	PAT.OfficePhone,
	MPAT.EDC, 
	MPAT.MaternityStatusId,
	STAT.MaternityStatusDesc, 
	MPAT.Notes, 
	PRO.ProviderId,
	PRO.ProviderName, 
	PRO.ProviderCode,
	MPAT.CreatedDate, 
	MPAT.UpdatedDate, 
	MPAT.CreatedBy, 
	MPAT.UpdatedBy,
	PAT.DisplayAge,
	MPAT.MaternityTeamId,
	TEAM.MaternityTeamDesc
FROM PROVIDER AS PRO 
	INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
	ON PRO.ProviderId = PCM.ProviderId 
	RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
	INNER JOIN PATIENT AS PAT 
	ON MPAT.PatientId = PAT.PatientId 
	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
	LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
	ON PAT.StateId = LOC.GeographicLocationId 
	ON PCM.PatientID = PAT.PatientId
	INNER JOIN MATERNITY_STATUS AS STAT
	ON MPAT.MaternityStatusId = STAT.MaternityStatusId
	INNER JOIN MATERNITY_TEAM AS TEAM
	ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
WHERE (MPAT.MaternityStatusId IN (0))
ORDER BY PAT.FullName
END
ELSE IF @mth = 13
BEGIN
SELECT     
	MPAT.MaternityPatientId, 
	MPAT.PatientId,
	PAT.FullName, 
	FMP.FamilyMemberPrefixCode, 
	PAT.SponsorSSN, 
	PAT.DOB, 
	PAT.StreetAddress1, 
	PAT.StreetAddress2, 
	PAT.StreetAddress3, 
	PAT.City, 
	PAT.ZipCode, 
	LOC.GeographicLocationAbbrev, 
	PAT.Phone, 
	PAT.OfficePhone,
	MPAT.EDC, 
	MPAT.MaternityStatusId,
	STAT.MaternityStatusDesc, 
	MPAT.Notes, 
	PRO.ProviderId,
	PRO.ProviderName, 
	PRO.ProviderCode,
	MPAT.CreatedDate, 
	MPAT.UpdatedDate, 
	MPAT.CreatedBy, 
	MPAT.UpdatedBy,
	PAT.DisplayAge,
	MPAT.MaternityTeamId,
	TEAM.MaternityTeamDesc
FROM PROVIDER AS PRO 
	INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
	ON PRO.ProviderId = PCM.ProviderId 
	RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
	INNER JOIN PATIENT AS PAT 
	ON MPAT.PatientId = PAT.PatientId 
	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
	LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
	ON PAT.StateId = LOC.GeographicLocationId 
	ON PCM.PatientID = PAT.PatientId
	INNER JOIN MATERNITY_STATUS AS STAT
	ON MPAT.MaternityStatusId = STAT.MaternityStatusId
	INNER JOIN MATERNITY_TEAM AS TEAM
	ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
WHERE (MPAT.MaternityStatusId IN (0))
AND MPAT.EDC NOT BETWEEN dbo.FirstDayofMonth(DATEADD(MONTH,-2,GETDATE())) AND dbo.LastDayofMonth(DATEADD(MONTH,9,GETDATE()))
ORDER BY PAT.FullName
END
ELSE
BEGIN
--Month Range
SELECT     
	MPAT.MaternityPatientId, 
	MPAT.PatientId,
	PAT.FullName, 
	FMP.FamilyMemberPrefixCode, 
	PAT.SponsorSSN, 
	PAT.DOB, 
	PAT.StreetAddress1, 
	PAT.StreetAddress2, 
	PAT.StreetAddress3, 
	PAT.City, 
	PAT.ZipCode, 
	LOC.GeographicLocationAbbrev, 
	PAT.Phone, 
	PAT.OfficePhone,
	MPAT.EDC, 
	MPAT.MaternityStatusId,
	STAT.MaternityStatusDesc, 
	MPAT.Notes, 
	PRO.ProviderId,
	PRO.ProviderName, 
	PRO.ProviderCode,
	MPAT.CreatedDate, 
	MPAT.UpdatedDate, 
	MPAT.CreatedBy, 
	MPAT.UpdatedBy,
	PAT.DisplayAge,
	MPAT.MaternityTeamId,
	TEAM.MaternityTeamDesc
FROM PROVIDER AS PRO 
	INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
	ON PRO.ProviderId = PCM.ProviderId 
	RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
	INNER JOIN PATIENT AS PAT 
	ON MPAT.PatientId = PAT.PatientId 
	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
	LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
	ON PAT.StateId = LOC.GeographicLocationId 
	ON PCM.PatientID = PAT.PatientId
	INNER JOIN MATERNITY_STATUS AS STAT
	ON MPAT.MaternityStatusId = STAT.MaternityStatusId
	INNER JOIN MATERNITY_TEAM AS TEAM
	ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
WHERE (MPAT.MaternityStatusId IN (0))
AND MPAT.EDC BETWEEN dbo.FirstDayofMonth(DATEADD(MONTH,@mth -3,GETDATE())) AND dbo.LastDayofMonth(DATEADD(MONTH,@mth -3,GETDATE()))
ORDER BY PAT.FullName
END
