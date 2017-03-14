create PROCEDURE [dbo].[procENET_Active_Directory_Account_SelectSigned]

 AS
SELECT     
	ADA.LastName + ', ' + ADA.FirstName + ' ' + ADA.MiddleName AS AlphaName, 
	ADA.Title, 
	ADA.LoginID, 
	CASE CAST(ADA.SignedDate AS varchar(50)) 
		WHEN 'Jan  1 1776 12:00AM' THEN '' 
		ELSE CAST(ADA.SignedDate AS varchar(50)) 
	END AS SignedDate, 
	CASE CAST(ADA.SupervisorSignedDate AS varchar(50)) 
		WHEN 'Jan  1 1776 12:00AM' THEN '' 
		ELSE CAST(ADA.SupervisorSignedDate AS varchar(50)) 
	END AS SupervisorSignedDate, 
	CASE CAST(ADA.CompletedDate AS varchar(50)) 
		WHEN 'Jan  1 1776 12:00AM' THEN '' 
		ELSE CAST(ADA.CompletedDate AS varchar(50)) 
	END AS CompletedDate, 
	CAST(ADA.LastReportedDate AS varchar(50)) AS LastReportedDate, 
	ISNULL(DESG.DesignationDesc, N'UNKNOWN') AS DesignationDesc, 
	ISNULL(AUD.DisplayName, N'Unknown') AS AudienceDesc
FROM DESIGNATION AS DESG 
	INNER JOIN TECHNICIAN AS TECH 
	ON DESG.DesignationId = TECH.DesignationId 
	INNER JOIN AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId 
	RIGHT OUTER JOIN ACTIVE_DIRECTORY_ACCOUNT AS ADA 
	ON TECH.LoginId = ADA.LoginID
WHERE (ADA.Inactive = 0) 
	AND (ADA.IsHidden = 0)
	AND (ADA.ServiceAccount = 0) 
	AND (ADA.SignedDate > '1/1/1776') 
	 
	OR (ADA.Inactive = 0) 
	AND (ADA.IsHidden = 0)
	AND (ADA.ServiceAccount = 0) 
	AND (ADA.SupervisorSignedDate > '1/1/1776') 
	
ORDER BY ADA.DesignationDesc,ADA.LastName, ADA.FirstName, ADA.MiddleName

