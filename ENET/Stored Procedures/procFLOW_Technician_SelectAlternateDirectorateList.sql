CREATE PROCEDURE [dbo].[procFLOW_Technician_SelectAlternateDirectorateList]
(
	@dir bigint,
	@grp int,
	@usr int,
	@typ int
)
AS

SELECT     
	Tech.UserId,
	RTRIM(Tech.UFName) AS UFName,
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName,
	Tech.Suffix
FROM
	TECHNICIAN AS TECH 
	INNER JOIN AUDIENCE AS AUDLVL1 
	ON TECH.AudienceId = AUDLVL1.AudienceId
WHERE     
	(TECH.AudienceId = @dir) 
	AND (TECH.Inactive = 0)
	AND (TECH.ServiceAccount = 0)
	AND (TECH.UserId NOT IN
		(
		SELECT     
			ALT.AlternateId
		FROM	TECHNICIAN_ALTERNATE AS ALT 
		INNER JOIN TECHNICIAN AS TECH 
		ON ALT.AlternateId = TECH.UserId
		WHERE ALT.AliasTypeId = @typ
		AND ALT.AliasId = @grp
		AND ALT.TechnicianId = @usr
	))
	AND Tech.UserId <> @usr
UNION
SELECT     
	Tech.UserId,
	RTRIM(Tech.UFName) AS UFName,
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName,
	Tech.Suffix
FROM
	TECHNICIAN AS TECH 
	INNER JOIN AUDIENCE AS AUDLVL2 
	ON TECH.AudienceId = AUDLVL2.AudienceId
WHERE
	(TECH.Inactive = 0) 
	AND (AUDLVL2.ReportsUnder = @dir)
	AND (TECH.ServiceAccount = 0)
	AND (TECH.UserId NOT IN
		(
		SELECT     
			ALT.AlternateId
		FROM	TECHNICIAN_ALTERNATE AS ALT 
		INNER JOIN TECHNICIAN AS TECH 
		ON ALT.AlternateId = TECH.UserId
		WHERE ALT.AliasTypeId = @typ
		AND ALT.AliasId = @grp
		AND ALT.TechnicianId = @usr
	))
	AND Tech.UserId <> @usr
UNION
SELECT
	Tech.UserId,
	RTRIM(Tech.UFName) AS UFName,
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName,
	Tech.Suffix
FROM
	TECHNICIAN AS TECH 
	INNER JOIN AUDIENCE AS AUDLVL3 
	ON TECH.AudienceId = AUDLVL3.AudienceId
WHERE
	(TECH.Inactive = 0) 
	AND (TECH.ServiceAccount = 0) 
	AND (AUDLVL3.ReportsUnder IN
		(
		SELECT DISTINCT TECH.AudienceId
		FROM TECHNICIAN AS TECH 
			INNER JOIN AUDIENCE AS AUDLVL2 
			ON TECH.AudienceId = AUDLVL2.AudienceId
		WHERE (TECH.Inactive = 0) 
			AND (TECH.ServiceAccount = 0) 
			AND (AUDLVL2.ReportsUnder = @dir)))
	AND (TECH.UserId NOT IN
		(
		SELECT     
			ALT.AlternateId
		FROM	TECHNICIAN_ALTERNATE AS ALT 
		INNER JOIN TECHNICIAN AS TECH 
		ON ALT.AlternateId = TECH.UserId
		WHERE ALT.AliasTypeId = @typ
		AND ALT.AliasId = @grp
		AND ALT.TechnicianId = @usr
	))
	AND Tech.UserId <> @usr
ORDER BY ULName,UFName,UMName







