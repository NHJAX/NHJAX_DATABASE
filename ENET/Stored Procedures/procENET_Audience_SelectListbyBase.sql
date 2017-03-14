CREATE PROCEDURE [dbo].[procENET_Audience_SelectListbyBase]
(
	@bas int
)
 AS

SELECT
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName
FROM
	AUDIENCE AS AUD 
WHERE  (AUD.AudienceCategoryId IN (1,2,3,7)) 
	AND DataLength(AUD.DisplayName) > 0
	AND AUD.Inactive = 0
	AND AUD.BaseId = @bas
ORDER BY AUD.SortOrder, AUD.DisplayName

