
create PROCEDURE [dbo].[procODS_APPOINTMENT_STATUS_Select]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
	
SELECT AppointmentStatusId,
	AppointmentStatusKey,
	AppointmentStatusDesc
FROM APPOINTMENT_STATUS
WHERE AppointmentStatusKey = @key;

