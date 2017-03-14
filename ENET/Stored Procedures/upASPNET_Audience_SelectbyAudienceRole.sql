

create PROCEDURE [dbo].[upASPNET_Audience_SelectbyAudienceRole] 
(
	@role varchar(256),
	@aud bigint
)
AS
SELECT     
	TECH.UserId, 
	TECH.ULName, 
	TECH.UFName, 
	TECH.UMName
FROM         
	aspnet_Users AS AUSR 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUSR.UserName = TECH.LoginId 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON AUSR.UserId = UIR.UserId 
	INNER JOIN aspnet_Roles AS ROLE 
	ON UIR.RoleId = ROLE.RoleId
WHERE (TECH.Inactive = 0) 
	AND (ROLE.RoleName = @role)
	AND TECH.AudienceId = @aud




