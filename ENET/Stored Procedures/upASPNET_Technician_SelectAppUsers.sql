

CREATE PROCEDURE [dbo].[upASPNET_Technician_SelectAppUsers] 
(
	@app varchar(256)
)
AS
SELECT   
	TECH.UserId,  
	TECH.ULName, 
	TECH.UFName, 
	TECH.UMName
FROM aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH
	ON aspnet_Users.UserName = TECH.LoginId
WHERE (ARL.Description = @app)
ORDER BY TECH.ULName,TECH.UFName,TECH.UMName



