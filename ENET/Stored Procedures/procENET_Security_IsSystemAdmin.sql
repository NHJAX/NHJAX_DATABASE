CREATE PROCEDURE [dbo].[procENET_Security_IsSystemAdmin]
(
	@usr int
)
 AS

SELECT  
	count(DISTINCT SG.SecurityGroupId) AS CountOfRoles
FROM aspnet_Users 
	INNER JOIN TECHNICIAN AS TECH 
	ON aspnet_Users.UserName = TECH.LoginId 
	INNER JOIN aspnet_UsersInRoles 
	ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId 
	INNER JOIN aspnet_Roles AS ROLES
	INNER JOIN TECHNICIAN_SECURITY_LEVEL AS TSL 
	ON ROLES.RoleId = TSL.RoleId 
	INNER JOIN SECURITY_GROUP AS SG 
	ON ROLES.Description = SG.SecurityGroupDesc 
	ON aspnet_UsersInRoles.RoleId = ROLES.RoleId 
	AND TECH.UserId = TSL.UserId
WHERE (TSL.UserId = @usr) 
	AND (ROLES.RoleName = 'System Admin')
	AND TECH.Inactive = 0
