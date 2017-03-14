CREATE PROCEDURE [dbo].[procAD_Technician_SelectbyLogin]
(
	@login varchar(256)
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
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
    Tech.Inactive, 
	Tech.LoginId, 
	BASE.BaseCode,
	Tech.SSN,
	Tech.distinguishedName,
	Aud.OrgChartCode,
	Aud.DisplayName,
	Tech.Suffix,
	Tech.ADExpiresDate,
	Tech.ADLoginDate,
	Tech.UpdatedDate,
	Tech.DoDEDI
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = Aud.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Aud.AudienceId = Tech.AudienceId
WHERE Tech.LoginId = @login






