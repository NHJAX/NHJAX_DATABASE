
create PROCEDURE [dbo].[procODS_APPOINTMENT_TYPE_UpdateInac]
(
	@key numeric(10,3),
	@inac bit
)
AS
	SET NOCOUNT ON;
	
UPDATE APPOINTMENT_TYPE
SET Inactive = @inac,
	UpdatedDate = Getdate()
WHERE AppointmentTypeKey = @key;

