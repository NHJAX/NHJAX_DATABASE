
CREATE PROCEDURE [dbo].[procFLOW_Audience_SelectDepartmentsbyGroup]
(
	@grp int
)
AS
SELECT DISTINCT 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.OrgChartCode, 
	AUD.ReportsUnder, 
	AUD.IsSubGroup, 
	AUD.CreatedDate, 
	AUD.UpdatedDate, 
	AUD.CreatedBy, 
	AUD.UpdatedBy, 
	AUD.AudienceCategoryId, 
	AUD.AudiencePhone, 
	AUD.AudienceFax, 
	AUD.AudiencePager, 
	AUD.Inactive, 
	AUD.OldDepartmentId, 
	AUD.SecurityGroupId, 
	AUD.BaseId, 
	ISNULL(TECH.UserId, 0) AS HeadId, 
	ISNULL(TECH.EMailAddress, '') AS HeadEMail,
	AUD.IsVisible,
	AUD.IsSpecialSoftware,
	AUD.IsCustomPR
FROM	TECHNICIAN AS TECH 
	INNER JOIN vwAudienceMemberDepartmentHeads AS AH 
	ON TECH.UserId = AH.TechnicianId 
	RIGHT OUTER JOIN AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN_SECURITY_LEVEL AS TSL 
	INNER JOIN TECHNICIAN 
	ON TSL.UserId = TECHNICIAN.UserId 
	ON AUD.AudienceId = TECHNICIAN.AudienceId 
	ON AH.AudienceId = AUD.AudienceId
WHERE     (AUD.AudienceCategoryId IN (1,2,3,7)) 
	AND (TSL.SecurityGroupId = @grp)
ORDER BY AUD.AudienceCategoryId, AUD.DisplayName






