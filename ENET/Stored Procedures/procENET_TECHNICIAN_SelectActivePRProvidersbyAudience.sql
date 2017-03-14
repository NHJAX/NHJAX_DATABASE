
CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectActivePRProvidersbyAudience] 
(
	@aud bigint
)
AS
SELECT DISTINCT
	TECH.UserId, 
	RTRIM(TECH.UFName) AS UFName, 
	RTRIM(TECH.ULName) AS ULName, 
	RTRIM(TECH.UMName) AS UMName, 
	TECH.Suffix
FROM aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH 
	ON aspnet_Users.UserName = TECH.LoginId 
WHERE (ARL.Description = 'PeerReview') 
	AND (TECH.Inactive = 0) 
	AND (TECH.UserId > 0) 
	AND (TECH.AudienceId = @aud)
	AND (TECH.UserId NOT IN
		(SELECT 
			TechnicianId
		FROM AUDIENCE_MEMBER
		WHERE (AudienceId IN (280)
		)
		)
		) 
UNION
SELECT DISTINCT 
	TECH.UserId, 
	RTRIM(TECH.UFName) AS UFName, 
	RTRIM(TECH.ULName) AS ULName, 
	RTRIM(TECH.UMName) AS UMName, 
	TECH.Suffix
FROM AUDIENCE_ALTERNATE AS ALT 
	INNER JOIN aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH 
	ON aspnet_Users.UserName = TECH.LoginId 
	ON ALT.TechnicianId = TECH.UserId
WHERE (ARL.Description = 'PeerReview') 
	AND (TECH.Inactive = 0) 
	AND (TECH.UserId > 0) 
	AND (ALT.AudienceId = @aud) 
	AND (TECH.UserId NOT IN
		(SELECT
			TechnicianId
		FROM AUDIENCE_MEMBER
		WHERE (AudienceId IN (280)
		)
		)
		)
ORDER BY ULName, UFName, UMName


