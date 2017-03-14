
create PROCEDURE [dbo].[procFLOW_Audience_SelectByCategory]
(
	@ac int
)
AS
SELECT     
	AudienceId, 
	AudienceDesc, 
	DisplayName, 
	OrgChartCode, 
	ReportsUnder, 
	IsSubGroup, 
	CreatedDate, 
	UpdatedDate, 
	CreatedBy, 
	UpdatedBy, 
	AudienceCategoryId, 
	AudiencePhone, 
	AudienceFax, 
	AudiencePager, 
	Inactive, 
	OldDepartmentId, 
	SecurityGroupId
FROM AUDIENCE
WHERE AudienceCategoryId = @ac
ORDER BY AudienceDesc



