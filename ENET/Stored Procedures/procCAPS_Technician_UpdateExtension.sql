create PROCEDURE [dbo].[procCAPS_Technician_UpdateExtension]
(
	@usr int,
	@uby int,
	@udate datetime,
	@ext varchar(10)
)
AS
UPDATE TECHNICIAN SET
	Extension = @ext,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


