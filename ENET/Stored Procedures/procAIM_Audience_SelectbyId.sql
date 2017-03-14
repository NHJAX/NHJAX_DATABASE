
CREATE PROCEDURE [dbo].[procAIM_Audience_SelectbyId]
(
	@aud bigint
)
AS
SELECT     
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.OrgChartCode, 
	AUD.ReportsUnder, 
	AUD.AudiencePhone, 
	AUD.BaseId, 
	ISNULL(TECH.UserId, 0) AS HeadId
FROM
	TECHNICIAN AS TECH 
	INNER JOIN vwAudienceMemberDepartmentHeads AS AH 
	ON TECH.UserId = AH.TechnicianId 
	RIGHT OUTER JOIN AUDIENCE AS AUD 
	ON AH.AudienceId = AUD.ReportsUnder
WHERE  (AUD.AudienceId = @aud)
ORDER BY AUD.SortOrder, AUD.AudienceDesc







