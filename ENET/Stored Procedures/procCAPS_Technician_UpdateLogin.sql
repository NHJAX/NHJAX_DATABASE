create PROCEDURE [dbo].[procCAPS_Technician_UpdateLogin]
(
	@usr int,
	@uby int,
	@udate datetime,
	@log nvarchar(25)
)
AS
UPDATE TECHNICIAN SET
	LoginId = @log,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


