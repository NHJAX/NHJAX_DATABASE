
create PROCEDURE [dbo].[procODS_APPOINTMENT_STATUS_Insert]
(
	@key numeric(8,3),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO APPOINTMENT_STATUS
(
	AppointmentStatusKey,
	AppointmentStatusDesc
) 
VALUES
(
	@key,
	@desc
);
SELECT SCOPE_IDENTITY();
