create PROCEDURE [dbo].[procENET_ACTIVE_DIRECTORY_ACCOUNT_SelectAIM]

 AS

SELECT DISTINCT 
	ADA.ActiveDirectoryAccountId, 
	ADA.DisplayName, 
	ADA.LastName, 
	ADA.FirstName, 
	ADA.MiddleName, 
	ADA.Description, 
	ISNULL(ISNULL(DIR.DisplayName, ADA.DirectorateDesc), 'Unknown') AS DirectorateDesc, 
	ADA.LoginID, 
	ISNULL(ISNULL(AUD.DisplayName, ADA.AudienceDesc), 'Unknown') AS AudienceDesc, 
	ADA.ADExpiresDate, 
	ADA.ADLoginDate, 
	ADA.Inactive, 
	ADA.ADCreatedDate, 
	CAST(ADA.Remarks AS varchar(4000)) AS Remarks, 
	ADA.SignedDate, 
	ADA.SupervisorSignedDate, 
	ADA.LBDate, 
	ADA.PSQDate, 
	ADA.CompletedDate, 
	ADA.ServiceAccount, 
	TECH.UserId, 
	ADA.SSN, 
	ADA.ENetStatus, 
	ADA.LastReportedDate, 
	ADA.IsHidden, 
	ISNULL(TECH.DesignationId, 0) AS DesignationId, 
	ADA.SecurityStatusId,
	ADA.Title,
	ADA.DoDEDI,
	ADA.distinguishedName
FROM AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUD.AudienceId = TECH.AudienceId 
	INNER JOIN vwENET_Audience_Directorate AS AUDDIR 
	ON AUD.AudienceId = AUDDIR.AudienceId 
	INNER JOIN AUDIENCE AS DIR 
	ON AUDDIR.DirectorateId = DIR.AudienceId 
	RIGHT OUTER JOIN ACTIVE_DIRECTORY_ACCOUNT AS ADA 
	ON TECH.LoginId = ADA.LoginID
WHERE LastReportedDate > DATEADD(YEAR, -1, GETDATE())

