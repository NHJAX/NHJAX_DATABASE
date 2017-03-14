create PROCEDURE [dbo].[procCAPS_Technician_UpdateBase]
(
	@usr int,
	@uby int,
	@udate datetime,
	@bas int
)
AS
UPDATE TECHNICIAN SET
	BaseId = @bas,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


