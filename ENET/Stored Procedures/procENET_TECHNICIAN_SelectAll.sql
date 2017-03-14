CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectAll]
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
	Tech.DoDEDI
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = Aud.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Aud.AudienceId = Tech.AudienceId
WHERE  Tech.UserId > 0
ORDER BY TECH.SortOrder,TECH.ULName,TECH.UFName,TECH.UMName






