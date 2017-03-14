
create PROCEDURE [dbo].[procENET_Audience_SelectAlternatebyId]
(
	@usr int
)
AS

SELECT
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName AS DisplayName, 
	1 AS SortOrder
FROM	AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUD.AudienceId = TECH.AudienceId
WHERE     (TECH.UserId = @usr)

UNION
SELECT 
	ALT.AudienceId,
	AUD.AudienceDesc,
	AUD.DisplayName AS DisplayName,
	AUD.SortOrder AS SortOrder
FROM
	AUDIENCE AS AUD
	INNER JOIN AUDIENCE_ALTERNATE AS ALT
	ON AUD.AudienceId = ALT.AudienceId
WHERE  (ALT.TechnicianId = @usr)
ORDER BY SortOrder, DisplayName







