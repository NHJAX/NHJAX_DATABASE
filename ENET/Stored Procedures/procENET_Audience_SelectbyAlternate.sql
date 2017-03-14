
CREATE PROCEDURE [dbo].[procENET_Audience_SelectbyAlternate]
(
	@usr int
)
AS
SELECT     
	AUD.AudienceId, 
	AUD.AudienceDesc,
	AUD.DisplayName,
	AUD.SortOrder
FROM
	AUDIENCE AS AUD
WHERE  (AUD.Inactive = 0)
AND (AUD.AudienceCategoryId IN (1,2,3,7))
AND IsVisible = 1
AND (AUD.AudienceId NOT IN 
	(
		SELECT AudienceId
		FROM AUDIENCE_ALTERNATE
		WHERE TechnicianId = @usr
	))
UNION SELECT 
AUD.AudienceId, 
	AUD.AudienceDesc,
	AUD.DisplayName,
	AUD.SortOrder
FROM
	AUDIENCE AS AUD
WHERE  (AUD.Inactive = 0)
AND (SecurityGroupId = 17) 
AND (AudienceId NOT IN (74, 280, 343))
ORDER BY AUD.SortOrder, AUD.DisplayName








