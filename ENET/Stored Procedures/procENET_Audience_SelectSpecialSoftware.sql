CREATE PROCEDURE [dbo].[procENET_Audience_SelectSpecialSoftware]

 AS

SELECT
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
	AUD.SecurityGroupId, 
	AUD.BaseId, 
	ISNULL(TECH.UserId, 0) AS HeadId, 
	ISNULL(TECH.EMailAddress, '') AS HeadEMail,
	AUD.IsSpecialSoftware
FROM
	TECHNICIAN AS TECH 
	INNER JOIN vwAudienceMemberDepartmentHeads AS AH 
	ON TECH.UserId = AH.TechnicianId 
	RIGHT OUTER JOIN AUDIENCE AS AUD 
	ON AH.AudienceId = AUD.ReportsUnder
WHERE  DataLength(AUD.DisplayName) > 0
	AND AUD.Inactive = 0
	AND AUD.IsSpecialSoftware = 1
ORDER BY AUD.SortOrder,AUD.DisplayName

