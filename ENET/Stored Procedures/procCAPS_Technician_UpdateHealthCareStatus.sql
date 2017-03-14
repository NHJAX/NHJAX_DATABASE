create PROCEDURE [dbo].[procCAPS_Technician_UpdateHealthCareStatus]
(
	@usr int,
	@uby int,
	@udate datetime,
	@hstat int
)
AS
UPDATE TECHNICIAN SET
	HealthCareStatusId = @hstat,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


