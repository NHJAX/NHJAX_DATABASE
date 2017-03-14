
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectActive_20091130]

AS
	SET NOCOUNT ON;
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
	PAT.DisplayAge
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
WHERE (MPAT.MaternityStatusId IN (0))
ORDER BY PAT.FullName
