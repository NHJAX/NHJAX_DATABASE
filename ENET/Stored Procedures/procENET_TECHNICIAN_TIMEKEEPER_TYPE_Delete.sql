
create PROCEDURE [dbo].[procENET_TECHNICIAN_TIMEKEEPER_TYPE_Delete]
(
	@tty int
)
AS
DELETE FROM TECHNICIAN_TIMEKEEPER_TYPE
WHERE TechnicianTimekeeperTypeId = @tty






