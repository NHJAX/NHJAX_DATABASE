
CREATE PROCEDURE [dbo].[procENET_Audience_SelectActivebyGroup]
(
	@grp int
)
AS

--Extended query to include non-PR groups
IF @grp = 17
BEGIN
SELECT DISTINCT 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.AudienceCategoryId,
	AUD.SortOrder
FROM TECHNICIAN AS TECH 
	INNER JOIN TECHNICIAN_SECURITY_LEVEL AS TSL 
	ON TECH.UserId = TSL.UserId 
	INNER JOIN AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId
WHERE (AUD.Inactive = 0) 
	AND (AUD.AudienceCategoryId IN (1,2,3,7)) 
	AND (AUD.IsVisible = 1) 
	AND (TSL.SecurityGroupId = @grp)
	AND (AUD.AudienceId > 0)

UNION SELECT
	DISTINCT 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.AudienceCategoryId,
	AUD.SortOrder
FROM AUDIENCE AS AUD
WHERE (AUD.AudienceCategoryId = 4
AND AUD.SecurityGroupId = @grp)

UNION SELECT
	DISTINCT 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.AudienceCategoryId,
	AUD.SortOrder
FROM AUDIENCE AS AUD
WHERE AUD.AudienceId IN (162,59,311,413,455)
ORDER BY AUD.SortOrder, AUD.DisplayName
--Added third union to handle specific exceptions (i.e. audiology,clinical nutrition)
END

ELSE
BEGIN
SELECT DISTINCT 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.AudienceCategoryId,
	AUD.SortOrder
FROM TECHNICIAN AS TECH 
	INNER JOIN TECHNICIAN_SECURITY_LEVEL AS TSL 
	ON TECH.UserId = TSL.UserId 
	INNER JOIN AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId
WHERE (AUD.Inactive = 0) 
	AND (AUD.AudienceCategoryId IN (1,2,3,7)) 
	AND (AUD.IsVisible = 1) 
	AND (TSL.SecurityGroupId = @grp)
	AND (AUD.AudienceId > 0)

UNION SELECT
	DISTINCT 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.AudienceCategoryId,
	AUD.SortOrder
FROM AUDIENCE AS AUD
WHERE (AUD.AudienceCategoryId = 4
AND AUD.SecurityGroupId = @grp)
END





