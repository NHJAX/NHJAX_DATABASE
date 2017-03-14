create PROCEDURE [dbo].[procCAPS_Technician_UpdateDeployed20090713]
(
	@usr int,
	@uby int,
	@udate datetime,
	@dep bit
)
AS
UPDATE TECHNICIAN SET
	Deployed = @dep,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


