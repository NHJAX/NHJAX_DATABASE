create PROCEDURE [dbo].[upENET_Audience_Select]

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
	AC.AudienceCategoryDesc, 
	AUD.AudiencePhone, 
	AUD.AudienceFax, 
	AUD.AudiencePager, 
	AUD.Inactive, 
	AUD.SecurityGroupId
FROM	AUDIENCE AS AUD 
	INNER JOIN AUDIENCE_CATEGORY AS AC 
	ON AUD.AudienceCategoryId = AC.AudienceCategoryId



