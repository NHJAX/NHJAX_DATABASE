CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_UpdatebyID]
(
	@usr int,
	@uby int,
	@udate datetime
)
AS
UPDATE TECHNICIAN SET
	Inactive = 1,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


