
CREATE PROCEDURE [dbo].[procENET_Audience_SelectActive]

AS
SELECT     
	AUD.AudienceId, 
	AUD.AudienceDesc,
	AUD.DisplayName
FROM
	AUDIENCE AS AUD
WHERE  (AUD.Inactive = 0)
AND (AUD.AudienceCategoryId IN (1,2,3,7))
AND IsVisible = 1
ORDER BY AUD.SortOrder, AUD.DisplayName







