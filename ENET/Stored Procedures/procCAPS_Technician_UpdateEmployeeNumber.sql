create PROCEDURE [dbo].[procCAPS_Technician_UpdateEmployeeNumber]
(
	@usr int,
	@uby int,
	@udate datetime,
	@enum int
)
AS
UPDATE TECHNICIAN SET
	EmployeeNumber = @enum,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


