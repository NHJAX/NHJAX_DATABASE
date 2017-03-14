CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectbyAudience]
(
	@aud bigint
)
 AS

SELECT     
	MEM.TechnicianId, TECH.EMailAddress
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN TECHNICIAN AS TECH 
	ON MEM.TechnicianId = TECH.UserId
WHERE	(MEM.AudienceId = @aud) 
	AND (DataLength(TECH.EMailAddress) > 0)

