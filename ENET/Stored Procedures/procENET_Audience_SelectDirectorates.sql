CREATE PROCEDURE [dbo].[procENET_Audience_SelectDirectorates]

AS

SELECT DISTINCT 
	DIR.DirectorateId, 
	AUD.AudienceDesc,
	AUD.DisplayName,
	AUD.SortOrder
FROM vwENET_AUDIENCE_DIRECTORATE AS DIR 
	INNER JOIN AUDIENCE AS AUD 
	ON DIR.DirectorateId = AUD.AudienceId
WHERE (DIR.DirectorateId > 0) 
	AND (AUD.Inactive = 0)
ORDER BY AUD.SortOrder, AUD.DisplayName

