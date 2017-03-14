create PROCEDURE [dbo].[procCAPS_Technician_Alternate_Disable]
(
	@usr int
)
 AS
DELETE FROM TECHNICIAN_ALTERNATE
WHERE TechnicianId = @usr;



