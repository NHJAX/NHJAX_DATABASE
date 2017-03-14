

create PROCEDURE [dbo].[procASPNET_Technician_SelectbyAppUser] 
(
	@grp int,
	@usr int
)
AS
SELECT     
	TECH.UserId, 
	ARL.RoleId
FROM aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH 
	ON aspnet_Users.UserName = TECH.LoginId 
	INNER JOIN SECURITY_GROUP AS GRP 
	ON ARL.Description = GRP.SecurityGroupDesc
WHERE	(TECH.UserId = @usr) AND (GRP.SecurityGroupId = @grp)






