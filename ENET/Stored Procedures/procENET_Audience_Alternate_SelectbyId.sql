
CREATE PROCEDURE [dbo].[procENET_Audience_Alternate_SelectbyId]
(
	@usr int
)
AS

SELECT
	CAST(0 AS bigint) AS AudienceAlternateId,     
	AUD.AudienceId, 
	@usr AS TechnicianId,
	AUD.AudienceDesc, 
	AUD.DisplayName AS DisplayName, 
	1 AS SortOrder
FROM	AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUD.AudienceId = TECH.AudienceId
WHERE     (TECH.UserId = @usr)

UNION
SELECT 
	ALT.AudienceAlternateId,
	ALT.AudienceId,
	ALT.TechnicianId,    
	AUD.AudienceDesc,
	AUD.DisplayName AS DisplayName,
	AUD.SortOrder AS SortOrder
FROM
	AUDIENCE AS AUD
	INNER JOIN AUDIENCE_ALTERNATE AS ALT
	ON AUD.AudienceId = ALT.AudienceId
WHERE  (ALT.TechnicianId = @usr)
ORDER BY SortOrder, DisplayName







