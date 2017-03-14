
CREATE PROCEDURE [dbo].[procENET_Security_Group_Select_ListbyUser]
(
	@usr int
) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
	SG.SecurityGroupId, 
	SG.SecurityGroupDesc, 
	TSL.RoleId, 
	TSL.ReadOnly,
	aspnet_Roles.RoleName
FROM aspnet_Users 
	INNER JOIN TECHNICIAN AS TECH 
	ON aspnet_Users.UserName = TECH.LoginId 
	INNER JOIN aspnet_UsersInRoles 
	ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId 
	INNER JOIN aspnet_Roles 
	INNER JOIN TECHNICIAN_SECURITY_LEVEL AS TSL 
	ON aspnet_Roles.RoleId = TSL.RoleId 
	INNER JOIN SECURITY_GROUP AS SG 
	ON aspnet_Roles.Description = SG.SecurityGroupDesc 
	ON aspnet_UsersInRoles.RoleId = aspnet_Roles.RoleId 
	AND TECH.UserId = TSL.UserId
WHERE (TSL.UserId = @usr) 
	AND (SG.SecurityGroupId > 0)
	AND SG.Inactive = 0
ORDER BY SG.SecurityGroupDesc
END

