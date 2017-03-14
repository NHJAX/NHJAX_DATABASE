CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectEMailbyAudience]
(
	@aud bigint
)
 AS

SELECT     
	TECH.EMailAddress
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN TECHNICIAN AS TECH 
	ON MEM.TechnicianId = TECH.UserId
WHERE	(MEM.AudienceId = @aud) 
	AND (DataLength(TECH.EMailAddress) > 0)
	AND Tech.Inactive = 0
	AND (TECH.UserId NOT IN
		(
		SELECT UserId
		FROM TECHNICIAN_EXTENDED
		WHERE  (Deployed = 1) 
		AND (ReturnDate > GETDATE())
		)
		)

