CREATE PROCEDURE [dbo].[procENET_ApplicationsRolesUsers_RPT]
WITH EXEC AS CALLER
AS


SELECT  CONVERT(nvarchar(1000),U.UserName) AS AUser, 
        CONVERT(nvarchar(1000),R.RoleName) AS ARole, 
        CONVERT(nvarchar(1000),R.[Description]) as App 
FROM aspnet_UsersInRoles as UIR
  INNER JOIN aspnet_Users as U ON U.UserId = UIR.UserId
  INNER Join aspnet_Roles as R ON R.RoleId = UIR.RoleId
 WHERE U.LoweredUserName NOT LIKE '%NMED\%'
UNION
SELECT CONVERT(nvarchar(1000),T.ULName + ', ' 
		+ T.UFName + ' ' 
		+ T.UMName) AS AUser, 
        CONVERT(nvarchar(1000),A.DisplayName), 
        CONVERT(nvarchar(1000),SG.SecurityGroupDesc) 
FROM AUDIENCE_MEMBER AS AM
  INNER JOIN TECHNICIAN AS T ON T.UserId = AM.TechnicianId 
    AND T.DisplayName IS NOT NULL AND RTRIM(T.DisplayName) <> ''
  INNER JOIN AUDIENCE as A ON A.AudienceId = AM.AudienceId --AND A.AudienceCategoryId = 6
  INNER JOIN SECURITY_GROUP AS SG ON SG.SecurityGroupId = A.SecurityGroupId AND SG.Inactive = 0
ORDER BY App, ARole, AUser