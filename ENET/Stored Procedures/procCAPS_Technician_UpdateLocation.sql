create PROCEDURE [dbo].[procCAPS_Technician_UpdateLocation]
(
	@usr int,
	@uby int,
	@udate datetime,
	@loc varchar(100)
)
AS
UPDATE TECHNICIAN SET
	Location = @loc,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


