
CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_ALTERNATE_Select]
(
	@grp int,
	@usr int,
	@typ int
)
AS
SELECT     
	ALT.TechnicianAlternateId, 
	ALT.TechnicianId, 
	ALT.AlternateId, 
	ALT.AliasId, 
	ALT.AliasTypeId, 
	dbo.FormatDateWithoutTime(ALT.ExpireDate,2) As ExpireDate, 
	ALT.SendEmail, 
	ALT.CreatedDate, 
	TECH.UFName, 
	TECH.ULName, 
	TECH.UMName,
	Tech.Suffix
FROM	TECHNICIAN_ALTERNATE AS ALT 
INNER JOIN TECHNICIAN AS TECH 
ON ALT.AlternateId = TECH.UserId
WHERE ALT.AliasTypeId = @typ
AND ALT.AliasId = @grp
AND ALT.TechnicianId = @usr

ORDER BY TECH.ULName, TECH.UFName, TECH.UMName







