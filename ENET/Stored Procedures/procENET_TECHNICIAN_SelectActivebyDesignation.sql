CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectActivebyDesignation]
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
	WHERE Tech.Inactive = 0 AND Tech.UserId > 0 AND Tech.DoNotDisplay = 0
	AND Tech.DesignationId IN (@desg1,@desg2)
	ORDER BY TECH.SortOrder,TECH.ULName,TECH.UFName,TECH.UMName
END

ELSE IF @desg1 = 4 
BEGIN
	SELECT     
		TECH.UserId,
		TECH.UFName,
		TECH.ULName,
		TECH.UMName,
		Tech.Suffix,
		Tech.SortOrder
	FROM
		TECHNICIAN AS TECH 
	WHERE Tech.Inactive = 0 AND Tech.UserId > 0
	AND Tech.DesignationId = 4
	
	UNION
	SELECT     
		TECH.UserId,
		TECH.UFName,
		TECH.ULName,
		TECH.UMName,
		Tech.Suffix,
		Tech.SortOrder
	FROM
		TECHNICIAN AS TECH 
		INNER JOIN PERSONNEL_TYPE_LIST AS PTL
		ON TECH.UserId = PTL.UserId
	WHERE Tech.Inactive = 0 AND Tech.UserId > 0
	AND PTL.PersonnelTypeId = 11
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
	WHERE Tech.Inactive = 0 AND Tech.UserId > 0
	AND Tech.DesignationId = @desg1
	ORDER BY TECH.SortOrder,TECH.ULName,TECH.UFName,TECH.UMName
END






