CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateSupervisor]
(
	@usr int,
	@uby int,
	@udate datetime,
	@supe varchar(150)
)
AS

UPDATE TECHNICIAN SET
	Supervisor = @supe,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;
