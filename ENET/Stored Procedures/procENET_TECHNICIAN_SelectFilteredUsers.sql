

CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectFilteredUsers] 
(
	@name varchar(256)
)
AS
DECLARE @filter varchar(257)

SET @filter = @name + '%'
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
	Tech.SSN,
	AUD.DisplayName,
	BASE.BaseId,
	Tech.Suffix,
	Tech.DOB,
	Tech.DoDEDI,
	Tech.DesignationId,
	Tech.distinguishedName
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = AUD.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Aud.AudienceId = Tech.AudienceId
WHERE tech.Inactive = 0 AND (TECH.ULName + ',' 
		+ LTRIM(RTRIM(TECH.UFName)) + ' ' 
		+ LTRIM(RTRIM(TECH.UMName)) LIKE @filter)





