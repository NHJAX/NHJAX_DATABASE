﻿

CREATE PROCEDURE [dbo].[procASPNET_Technician_SelectAllAppUsers] 
(
	@app varchar(256)
)
AS
SELECT   
	Tech.UserId, 
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UFName) AS UFName, 
	RTRIM(Tech.UMName) AS UMName, 
	Tech.Title, 
    Tech.EMailAddress, 
	Tech.AudienceId, 
	Aud.AudienceDesc, 
	Tech.Location, 
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
    Tech.Inactive, 
	Tech.Comments,  
	Tech.LoginId, 
	BASE.BaseCode,
	TECH.SSN,
	Tech.Suffix,
	Tech.DOB,
	TECH.DoDEDI
FROM aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH
	ON aspnet_Users.UserName = TECH.LoginId
	INNER JOIN AUDIENCE AUD
	ON AUD.AudienceId = TECH.AudienceId
	INNER JOIN BASE
	ON Base.BaseId = AUD.BaseId
WHERE (ARL.Description = @app) AND Tech.UserId > 0
AND DateDiff(m,TECH.UpdatedDate,getdate()) < 13
ORDER BY TECH.SortOrder, TECH.ULName,TECH.UFName,TECH.UMName







