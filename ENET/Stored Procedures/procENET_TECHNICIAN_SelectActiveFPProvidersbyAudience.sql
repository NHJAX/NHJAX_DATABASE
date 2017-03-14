
CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectActiveFPProvidersbyAudience] 
(
	@aud bigint
)
AS
--*******************************************************************************
--* +++++++++++++++++++++++++++++++   CHANGE LOG   ++++++++++++++++++++++++++++++
--* CHANGED 8-19-2011, REE
--* ADDED COLUMN CONCATENATING NAME INTO ONE COLUMN.
--*******************************************************************************
--Uses Peer Review functionality - requires provider to be active in PR and
--in the correct department.
IF @aud = 82
BEGIN
SELECT DISTINCT
	TECH.UserId, 
	RTRIM(TECH.UFName) AS UFName, 
	RTRIM(TECH.ULName) AS ULName, 
	RTRIM(TECH.UMName) AS UMName, 
	TECH.Suffix,
	RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS FULLName
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
	AND (TECH.AudienceId IN (82,85,389,390,391))
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
	TECH.Suffix,
	RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS FULLName
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
	AND (ALT.AudienceId IN (82,85,389,390,391)) 
	AND (TECH.UserId NOT IN
		(SELECT
			TechnicianId
		FROM AUDIENCE_MEMBER
		WHERE (AudienceId IN (280)
		)
		)
		)
ORDER BY ULName, UFName, UMName
END
ELSE IF @aud = 0
BEGIN
SELECT DISTINCT
	TECH.UserId, 
	RTRIM(TECH.UFName) AS UFName, 
	RTRIM(TECH.ULName) AS ULName, 
	RTRIM(TECH.UMName) AS UMName, 
	TECH.Suffix,
	RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS FULLName
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
	AND (TECH.AudienceId IN (82,85,180,389,390,391))
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
	TECH.Suffix,
	RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS FULLName
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
	AND (ALT.AudienceId IN (82,85,180,389,390,391)) 
	AND (TECH.UserId NOT IN
		(SELECT
			TechnicianId
		FROM AUDIENCE_MEMBER
		WHERE (AudienceId IN (280)
		)
		)
		)
ORDER BY ULName, UFName, UMName
END
ELSE
BEGIN
SELECT DISTINCT
	TECH.UserId, 
	RTRIM(TECH.UFName) AS UFName, 
	RTRIM(TECH.ULName) AS ULName, 
	RTRIM(TECH.UMName) AS UMName, 
	TECH.Suffix,
	RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS FULLName
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
	TECH.Suffix,
	RTRIM(TECH.ULName) + ', ' + RTRIM(TECH.UFName) + ' ' + RTRIM(TECH.UMName) AS FULLName
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
END


