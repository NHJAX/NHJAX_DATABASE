create PROCEDURE [dbo].[procENET_Active_Directory_Account_SelectAllActiveUsers]

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
FROM AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUD.AudienceId = TECH.AudienceId 
	INNER JOIN vwENET_Audience_Directorate AS AUDDIR 
	ON AUD.AudienceId = AUDDIR.AudienceId 
	INNER JOIN AUDIENCE AS DIR 
	ON AUDDIR.DirectorateId = DIR.AudienceId 
	RIGHT OUTER JOIN ACTIVE_DIRECTORY_ACCOUNT AS ADA 
	ON TECH.LoginId = ADA.LoginID
	LEFT OUTER JOIN DESIGNATION AS DESG
	ON DESG.DesignationId = TECH.DesignationId 
WHERE     (1 = 1) AND ADA.Inactive = 0 
	AND ADA.ServiceAccount = 0 
	AND ADA.IsHidden = 0 
	AND datediff(day,ada.lastreporteddate,
		(SELECT TOP 1 LastReportedDate 
			FROM dbo.vwENET_ACTIVE_DIRECTORY_ACCOUNT_LastReportedDate)) < 3 
			AND datediff(day,ada.ADExpiresdate,getdate()) < 3 
ORDER BY ADA.LastName, ADA.FirstName, ADA.MiddleName

