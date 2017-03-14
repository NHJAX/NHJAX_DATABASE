
CREATE PROCEDURE [dbo].[procODS_APPOINTMENT_TYPE_Insert]
(
	@key numeric(10,3),
	@desc varchar(30),
	@code varchar(6),
	@inac bit
)
AS
	SET NOCOUNT ON;
	
INSERT INTO APPOINTMENT_TYPE
(
	AppointmentTypeKey,
	AppointmentTypeDesc,
	AppointmentTypeCode,
	Inactive
) 
VALUES
(
	@key,
	@desc,
	@code,
	@inac
);
SELECT SCOPE_IDENTITY();
