create PROCEDURE [dbo].[procCAPS_Technician_Alternate_Update]
(
	@ta bigint,
	@exp datetime,
	@mail bit
)
 AS
UPDATE TECHNICIAN_ALTERNATE
SET ExpireDate = @exp,
SendEmail = @mail
WHERE TechnicianAlternateId = @ta;



