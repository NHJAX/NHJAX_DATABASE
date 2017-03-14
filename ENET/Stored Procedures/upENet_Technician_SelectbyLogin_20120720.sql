
CREATE PROCEDURE [dbo].[upENet_Technician_SelectbyLogin_20120720](
	@net varchar(256)
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
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
    Tech.Inactive, 
	Tech.Comments, 
	Tech.SecurityLevelId, 
	Tech.LoginId, 
	BASE.BaseCode,
	Tech.SSN,
	Tech.AudienceId,
	Tech.Suffix,
	Tech.DOB
FROM   BASE 
	INNER JOIN DEPARTMENT Dept 
	ON BASE.BaseId = Dept.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Dept.DepartmentId = Tech.DepartmentId
WHERE
	Tech.LoginId = @net;


