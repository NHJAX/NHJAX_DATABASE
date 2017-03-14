create PROCEDURE [dbo].[procCAPS_Technician_UpdateUMName]
(
	@usr int,
	@uby int,
	@udate datetime,
	@mname varchar(50)
)
AS
UPDATE TECHNICIAN SET
	UMName = @mname,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


