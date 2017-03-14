CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectAllbyDesignation]
(
	@desg1 int,
	@desg2 int
)
AS

IF @desg2 > 0

BEGIN

SELECT   
	TECH.UserId,
	TECH.UFName,
	TECH.ULName,
	TECH.UMName,
	Tech.Suffix,
	TECH.SortOrder
FROM
	TECHNICIAN AS TECH 
WHERE Tech.UserId > 0 
	AND TECH.AudienceId = 420
	AND Tech.DesignationId IN (@desg1,@desg2)
UNION
SELECT   
	TECH.UserId,
	TECH.UFName,
	TECH.ULName,
	TECH.UMName,
	Tech.Suffix,
	TECH.SortOrder
FROM
	TECHNICIAN AS TECH 
WHERE Tech.UserId > 0 
	AND (Tech.DoNotDisplay = 0)
	AND Tech.DesignationId IN (@desg1,@desg2)
ORDER BY TECH.SortOrder,TECH.ULName,TECH.UFName,TECH.UMName

END

ELSE
BEGIN

SELECT 
   
	TECH.UserId,
	TECH.UFName,
	TECH.ULName,
	TECH.UMName,
	Tech.Suffix
FROM
	TECHNICIAN AS TECH 
WHERE Tech.UserId > 0
	AND Tech.DesignationId = @desg1
ORDER BY TECH.SortOrder,TECH.ULName,TECH.UFName,TECH.UMName
END






