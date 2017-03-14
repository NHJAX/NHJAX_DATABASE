create PROCEDURE [dbo].[procCAPS_Technician_UpdateCheckIn]
(
	@usr int,
	@uby int,
	@udate datetime,
	@cidt datetime
)
AS
UPDATE TECHNICIAN SET
	CheckInDate = @cidt,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


