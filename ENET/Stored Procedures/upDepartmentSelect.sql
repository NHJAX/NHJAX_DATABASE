
create PROCEDURE [dbo].[upDepartmentSelect]

AS
SELECT     
	CAST(AUD.AudienceId AS int) AS AudienceId, 
	AUD.DisplayName,
	AUD.OrgChartCode
FROM
	AUDIENCE AS AUD
WHERE  (AUD.Inactive = 0)
AND (AUD.AudienceCategoryId IN (1,2,3,7))
AND IsVisible = 1
AND OrgChartCode IS NOT NULL
ORDER BY AUD.SortOrder, AUD.DisplayName
--KSK Updated 2008-01-28 to reflect audience







