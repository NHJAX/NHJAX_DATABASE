

CREATE PROCEDURE [dbo].[procFLOW_Technician_SelectAlternateListbyApp] 
(
	@app varchar(256),
	@grp int,
	@usr int,
	@typ int
)
AS
SELECT   
	Tech.UserId,
	RTRIM(Tech.UFName) AS UFName,
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName,
	Tech.Suffix,
	Tech.SortOrder
FROM aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH
	ON aspnet_Users.UserName = TECH.LoginId
WHERE (ARL.Description = @app)
AND TECH.Inactive = 0 AND Tech.UserId > 0
AND TECH.UserId NOT IN 
	(
	SELECT     
		ALT.AlternateId
	FROM	TECHNICIAN_ALTERNATE AS ALT 
	INNER JOIN TECHNICIAN AS TECH 
	ON ALT.AlternateId = TECH.UserId
	WHERE ALT.AliasTypeId = @typ
	AND ALT.AliasId = @grp
	AND ALT.TechnicianId = @usr
	)
AND Tech.UserId <> @usr
ORDER BY TECH.SortOrder, TECH.ULName,TECH.UFName,TECH.UMName









