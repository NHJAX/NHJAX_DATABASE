create PROCEDURE [dbo].[procCAPS_Technician_Alternate_DeleteAll]
(
	@usr int,
	@alias bigint,
	@typ int
)
 AS
DELETE FROM TECHNICIAN_ALTERNATE
WHERE TechnicianId = @usr
AND AliasId = @alias
AND AliasTypeId = @typ;



