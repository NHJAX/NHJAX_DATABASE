
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectbyId]
(
	@mpat bigint
)
AS
	SET NOCOUNT ON;
		

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
	TEAM.MaternityTeamDesc,
	MPAT.FPProviderId,
	FPRO.ProviderName,
	ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
	ISNULL(DMIS.FacilityName, 'N/A'),
	ISNULL(DMIS_PCM.FacilityName, 'N/A'),
	UIC.UICCode
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
	INNER JOIN PROVIDER AS FPRO
	ON MPAT.FPProviderId = FPRO.ENetId
	INNER JOIN vwENET_TECHNICIAN AS TECH
	ON MPAT.UpdatedBy = TECH.UserId
	LEFT OUTER JOIN DMIS 
	ON PAT.DMISId = DMIS.DMISId
	LEFT OUTER JOIN DMIS AS DMIS_PCM
	ON PCM.DmisId = DMIS_PCM.DMISId
	LEFT OUTER JOIN UIC
	ON PAT.UICId = UIC.UICId
WHERE MPAT.MaternityPatientId = @mpat
ORDER BY PAT.FullName
END


