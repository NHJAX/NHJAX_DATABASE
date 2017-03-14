CREATE PROCEDURE [dbo].[procAIM_Technician_UpdateDate]
(
	@usr int,
	@uby int,
	@aim varchar(50) = 'Aim',
	@comp varchar(20) = ''
)
AS
UPDATE TECHNICIAN SET
	UpdatedBy = @uby,
	UpdatedDate = getdate(),
	Inactive = 0,
	AimVersion = @aim,
	ComputerName = @comp
WHERE UserId = @usr;


