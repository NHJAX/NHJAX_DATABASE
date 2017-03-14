
CREATE PROCEDURE [dbo].[procENET_Audience_SelectListTree]
(
	@aud bigint,
	@usr int = 0
)
AS
SELECT     
	DIR.AudienceId, 
	DIR.AudienceDesc,
	DIR.DisplayName AS DisplayName,
	DIR.SortOrder AS SortOrder
FROM
	AUDIENCE AS DIR
WHERE  (DIR.Inactive = 0)
AND (DIR.AudienceId = @aud)
AND IsVisible = 1

UNION
SELECT     
	DEPT.AudienceId, 
	DEPT.AudienceDesc, 
	DEPT.DisplayName AS DisplayName, 
	DEPT.SortOrder AS SortOrder
FROM	AUDIENCE AS DIR 
	INNER JOIN AUDIENCE AS DEPT 
	ON DIR.AudienceId = DEPT.ReportsUnder
WHERE (DIR.AudienceId = @aud)
	AND DEPT.Inactive = 0
	AND DEPT.IsVisible = 1

UNION
SELECT     
	DIV.AudienceId, 
	DIV.AudienceDesc, 
	DIV.DisplayName AS DisplayName, 
	DIV.SortOrder AS SortOrder
FROM	AUDIENCE AS DIR 
	INNER JOIN AUDIENCE AS DEPT 
	ON DIR.AudienceId = DEPT.ReportsUnder 
	INNER JOIN AUDIENCE AS DIV 
	ON DEPT.AudienceId = DIV.ReportsUnder
WHERE     (DIR.AudienceId = @aud)
	AND DIV.Inactive = 0
	AND DIV.IsVisible = 1

UNION
SELECT     
	SUB.AudienceId, 
	SUB.AudienceDesc, 
	SUB.DisplayName AS DisplayName, 
	SUB.SortOrder AS SortOrder
FROM	AUDIENCE AS DIR 
	INNER JOIN AUDIENCE AS DEPT 
	ON DIR.AudienceId = DEPT.ReportsUnder 
	INNER JOIN AUDIENCE AS DIV 
	ON DEPT.AudienceId = DIV.ReportsUnder 
	INNER JOIN AUDIENCE AS SUB 
	ON DIV.AudienceId = SUB.ReportsUnder
WHERE (DIR.AudienceId = @aud)
	AND SUB.Inactive = 0
	AND SUB.IsVisible = 1
	AND SUB.AudienceCategoryId = 7

UNION
SELECT
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName AS DisplayName, 
	AUD.SortOrder
FROM	AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUD.AudienceId = TECH.AudienceId
WHERE     (TECH.UserId = @usr)
AND Tech.UserId > 0

UNION
SELECT 
	ALT.AudienceId,
	AUD.AudienceDesc,
	AUD.DisplayName AS DisplayName,
	AUD.SortOrder AS SortOrder
FROM
	AUDIENCE AS AUD
	INNER JOIN AUDIENCE_ALTERNATE AS ALT
	ON AUD.AudienceId = ALT.AudienceId
WHERE  (ALT.TechnicianId = @usr)


ORDER BY SortOrder, DisplayName







