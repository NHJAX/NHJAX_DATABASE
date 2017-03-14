create PROCEDURE [dbo].[procCAPS_Technician_UpdateUFName]
(
	@usr int,
	@uby int,
	@udate datetime,
	@fname varchar(50)
)
AS
UPDATE TECHNICIAN SET
	UFName = @fname,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


