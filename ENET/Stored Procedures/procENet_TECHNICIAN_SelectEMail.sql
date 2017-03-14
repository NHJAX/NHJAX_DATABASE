
CREATE PROCEDURE [dbo].[procENet_TECHNICIAN_SelectEMail] AS
SELECT   
	TECH.UserId,  
	ISNULL(CAST(TECH.ULName AS varchar(40)),'') + ', ' + ISNULL(CAST(TECH.UFName as varchar(40)),'') + ' ' + ISNULL(CAST(TECH.UMName as varchar(40)),'') AS AlphaTech,
	ISNULL(CAST(TECH.UPhone as char(20)),'') AS Phone,
    ISNULL(CAST(TECH.Location as char(50)),'') AS Room,
	ISNULL(CAST(TECH.Title as char(50)),'') AS Title,
	ISNULL(CAST(AUD.AudienceDesc as char(50)),'') AS Department,
    ISNULL(CAST(TECH.EMailAddress as char(250)),'') AS EMail,
	ISNULL(CAST(AUD.DisplayName as char(50)),'') AS DisplayName,
	ISNULL(TECH.ServiceAccount,0) AS ServiceAccount
FROM   TECHNICIAN TECH 
	INNER JOIN AUDIENCE AUD 
	ON TECH.AudienceId = AUD.AudienceId
WHERE	(TECH.Inactive = 0) 
	AND (TECH.EMailAddress LIKE '%@mail.mil') 
ORDER BY ServiceAccount DESC,AlphaTech




