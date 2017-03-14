create PROCEDURE [dbo].[procCAPS_Technician_UpdateTitle]
(
	@usr int,
	@uby int,
	@udate datetime,
	@title varchar(50)
)
AS
UPDATE TECHNICIAN SET
	Title = @title,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


