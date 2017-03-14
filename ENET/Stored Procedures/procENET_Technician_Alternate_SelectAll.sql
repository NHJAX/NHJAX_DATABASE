
CREATE PROCEDURE [dbo].[procENET_Technician_Alternate_SelectAll]
(
	@grp int,
	@usr int
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
	TECH.Suffix
FROM	TECHNICIAN_ALTERNATE AS ALT 
INNER JOIN TECHNICIAN AS TECH 
ON ALT.TechnicianId = TECH.UserId
WHERE ALT.AliasId = @grp
AND ALT.AlternateId = @usr
AND (ALT.ExpireDate <= '1/1/1776' 
	OR ALT.ExpireDate >= dbo.startOfDay(getdate()))

UNION
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
ON ALT.TechnicianId = TECH.UserId
WHERE ALT.AliasTypeId = 2
AND ALT.AlternateId = @usr
AND (ALT.ExpireDate <= '1/1/1776' 
	OR ALT.ExpireDate >= dbo.startOfDay(getdate()))
	
ORDER BY TECH.ULName, TECH.UFName, TECH.UMName


