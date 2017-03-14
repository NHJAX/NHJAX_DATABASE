CREATE PROCEDURE [dbo].[upTechnicianSelect_20130107](
	@user int
)
AS

SELECT     
	Tech.UserId, 
	RTRIM(Tech.UFName) AS UFName, 
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName, 
	Tech.Title, 
             Tech.EMailAddress, 
	Tech.DepartmentId, 
	Dept.DCBILLET, 
	Tech.Location, 
	Tech.LastFour, 
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
             Tech.Inactive, 
	Tech.Comments, 
	Tech.SecurityLevelId, 
	Tech.LoginId, 
	BASE.BaseCode,
	Tech.Suffix
FROM   BASE 
	INNER JOIN DEPARTMENT Dept 
	ON BASE.BaseId = Dept.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Dept.DepartmentId = Tech.DepartmentId
WHERE
	Tech.UserId = @user;
