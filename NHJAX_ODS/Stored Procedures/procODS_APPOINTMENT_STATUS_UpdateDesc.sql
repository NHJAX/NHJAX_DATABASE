
create PROCEDURE [dbo].[procODS_APPOINTMENT_STATUS_UpdateDesc]
(
	@key numeric(8,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE APPOINTMENT_STATUS
SET AppointmentStatusDesc = @desc,
	UpdatedDate = Getdate()
WHERE AppointmentStatusKey = @key;

