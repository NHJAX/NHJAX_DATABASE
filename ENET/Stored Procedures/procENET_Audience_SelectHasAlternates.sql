
create PROCEDURE [dbo].[procENET_Audience_SelectHasAlternates]

AS
SELECT     
	AUD.AudienceId, 
	AUD.AudienceDesc,
	AUD.DisplayName
FROM
	AUDIENCE AS AUD
WHERE  (AUD.Inactive = 0)
AND HasAlternates = 1
ORDER BY AUD.SortOrder, AUD.DisplayName







