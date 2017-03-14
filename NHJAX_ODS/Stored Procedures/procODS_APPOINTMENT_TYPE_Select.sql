
CREATE PROCEDURE [dbo].[procODS_APPOINTMENT_TYPE_Select]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
	
SELECT AppointmentTypeId,
	AppointmentTypeKey,
	AppointmentTypeDesc,
	AppointmentTypeCode,
	Inactive
FROM APPOINTMENT_TYPE
WHERE AppointmentTypeKey = @key;

