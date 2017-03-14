CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectbyName]
(
	@lname varchar(50),
	@fname varchar(50)
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
	Tech.DoDEDI,
	Tech.DesignationId,
	Tech.distinguishedName
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = Aud.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Aud.AudienceId = Tech.AudienceId
WHERE Tech.ULName = @lname
	AND Tech.UFName = @fname






