

CREATE PROCEDURE [dbo].[upASPNET_Roles_SelectApp] 
(
	@app varchar(256)
)
AS
SELECT   
	RoleId,  
	RoleName
FROM aspnet_Roles
WHERE (Description = @app)
AND RoleName Not like 'Select%'



