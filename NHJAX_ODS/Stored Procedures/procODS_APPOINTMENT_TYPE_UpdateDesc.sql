
create PROCEDURE [dbo].[procODS_APPOINTMENT_TYPE_UpdateDesc]
(
	@key numeric(10,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE APPOINTMENT_TYPE
SET AppointmentTypeDesc = @desc,
	UpdatedDate = Getdate()
WHERE AppointmentTypeKey = @key;

