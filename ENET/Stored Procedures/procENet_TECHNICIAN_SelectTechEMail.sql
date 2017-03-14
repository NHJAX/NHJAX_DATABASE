
CREATE PROCEDURE [dbo].[procENet_TECHNICIAN_SelectTechEMail] 
(
	@app varchar(256)
)
AS
SELECT DISTINCT
	TECH.UserId,  
	ISNULL(CAST(TECH.ULName AS varchar(40)),'') + ', ' + ISNULL(CAST(TECH.UFName as varchar(40)),'') + ' ' + ISNULL(CAST(TECH.UMName as varchar(40)),'') AS AlphaTech,
	ISNULL(CAST(TECH.UPhone as char(20)),'') AS Phone,
    ISNULL(CAST(TECH.Location as char(50)),'') AS Room,
	ISNULL(CAST(TECH.Title as char(50)),'') AS Title,
	ISNULL(CAST(AUD.AudienceDesc as char(50)),'') AS Department,
    ISNULL(CAST(TECH.EMailAddress as char(250)),'') AS EMail,
	ISNULL(CAST(AUD.DisplayName as char(50)),'') AS DisplayName,
	ISNULL(TECH.ServiceAccount, 0) AS ServiceAccount,
	ISNULL(TECH.SortOrder,1) AS SortOrder
FROM         
	aspnet_Roles AS ARL 
	INNER JOIN aspnet_UsersInRoles AS UIR 
	ON ARL.RoleId = UIR.RoleId 
	INNER JOIN aspnet_Users 
	ON UIR.UserId = aspnet_Users.UserId 
	INNER JOIN TECHNICIAN AS TECH 
	ON aspnet_Users.UserName = TECH.LoginId
	INNER JOIN AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId
WHERE     
	(TECH.Inactive = 0) 
	AND (TECH.EMailAddress LIKE '%@mail.mil') 
	AND (ARL.Description = @app 
	OR ARL.Description = 'System Admin')
ORDER BY SortOrder,AlphaTech




