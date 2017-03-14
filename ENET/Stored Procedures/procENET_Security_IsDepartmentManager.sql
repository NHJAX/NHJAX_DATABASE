CREATE PROCEDURE [dbo].[procENET_Security_IsDepartmentManager]
(
	@usr int,
	@aud bigint
)
 AS

SELECT	AudienceId
FROM	TECHNICIAN
WHERE	(UserId = @usr) 
	AND (AudienceId = @aud)
	AND Inactive = 0
UNION
SELECT	AudienceId
FROM	AUDIENCE_ALTERNATE
WHERE	(TechnicianId = @usr) 
	AND (AudienceId = @aud)
