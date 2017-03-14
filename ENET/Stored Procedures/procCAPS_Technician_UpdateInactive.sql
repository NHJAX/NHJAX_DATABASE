create PROCEDURE [dbo].[procCAPS_Technician_UpdateInactive]
(
	@usr int,
	@uby int,
	@udate datetime,
	@inac bit
)
AS
UPDATE TECHNICIAN SET
	Inactive = @inac,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


