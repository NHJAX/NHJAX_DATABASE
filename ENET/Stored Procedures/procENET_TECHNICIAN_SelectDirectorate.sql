CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectDirectorate]
(
	@dir bigint
)
AS
--*************************************************************************
--*---------------------- C H A N G E   L O G ----------------------------*
--*************************************************************************
-- 4 April 2012 - Updated By Robert Evans SuprTEK
-- Changed query by adding: TECH.Title and TECH.EMailAddress
-- Changed to facilitate use by Quality Management DSR Application - REE
-- (Additionaly changed first query switched fname and lname to match unions)
--*************************************************************************

SELECT     
	TECH.UserId,
	TECH.UFName,
	TECH.ULName, 
	TECH.UMName,
	Tech.Suffix,
	TECH.Title,
	'mailto:' + RTRIM(TECH.EMailAddress) as EmailURL
FROM
	TECHNICIAN AS TECH 
	INNER JOIN AUDIENCE AS AUDLVL1 
	ON TECH.AudienceId = AUDLVL1.AudienceId
WHERE     
	(TECH.AudienceId = @dir) 
	AND (TECH.Inactive = 0)
	AND (TECH.ServiceAccount = 0)
	AND Tech.DoNotDisplay = 0
UNION
SELECT     
	TECH.UserId, 
	TECH.UFName, 
	TECH.ULName, 
	TECH.UMName,
	Tech.Suffix,
	TECH.Title,
	'mailto:' + RTRIM(TECH.EMailAddress) as EmailURL
FROM
	TECHNICIAN AS TECH 
	INNER JOIN AUDIENCE AS AUDLVL2 
	ON TECH.AudienceId = AUDLVL2.AudienceId
WHERE
	(TECH.Inactive = 0) 
	AND (AUDLVL2.ReportsUnder = @dir)
	AND (TECH.ServiceAccount = 0)
	AND Tech.DoNotDisplay = 0
UNION
SELECT
	TECH.UserId, 
	TECH.UFName, 
	TECH.ULName, 
	TECH.UMName,
	Tech.Suffix,
	TECH.Title,
	'mailto:' + RTRIM(TECH.EMailAddress) as EmailURL
FROM
	TECHNICIAN AS TECH 
	INNER JOIN AUDIENCE AS AUDLVL3 
	ON TECH.AudienceId = AUDLVL3.AudienceId
WHERE
	(TECH.Inactive = 0) 
	AND Tech.DoNotDisplay = 0
	AND (TECH.ServiceAccount = 0) 
	AND (AUDLVL3.ReportsUnder IN
		(
		SELECT DISTINCT TECH.AudienceId
		FROM TECHNICIAN AS TECH 
			INNER JOIN AUDIENCE AS AUDLVL2 
			ON TECH.AudienceId = AUDLVL2.AudienceId
		WHERE (TECH.Inactive = 0) 
			AND Tech.DoNotDisplay = 0
			AND (TECH.ServiceAccount = 0) 
			AND (AUDLVL2.ReportsUnder = @dir)))
			
ORDER BY TECH.ULName,TECH.UFName,TECH.UMName







