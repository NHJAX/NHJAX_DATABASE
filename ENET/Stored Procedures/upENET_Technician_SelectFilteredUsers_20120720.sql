

CREATE PROCEDURE [dbo].[upENET_Technician_SelectFilteredUsers_20120720] 
(
	@name varchar(256)
)
AS
DECLARE @filter varchar(257)

SET @filter = @name + '%'
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
	Tech.Suffix,
	Tech.DOB
FROM   BASE 
	INNER JOIN DEPARTMENT Dept 
	ON BASE.BaseId = Dept.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Dept.DepartmentId = Tech.DepartmentId
WHERE tech.Inactive = 0 AND (TECH.ULName + ',' 
		+ LTRIM(RTRIM(TECH.UFName)) + ' ' 
		+ LTRIM(RTRIM(TECH.UMName)) LIKE @filter)



