create PROCEDURE [dbo].[procCAPS_Technician_Alternate_Delete]
(
	@ta bigint
)
 AS
DELETE FROM TECHNICIAN_ALTERNATE
WHERE TechnicianAlternateId = @ta;



