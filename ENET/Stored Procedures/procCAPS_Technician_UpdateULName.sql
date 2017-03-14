create PROCEDURE [dbo].[procCAPS_Technician_UpdateULName]
(
	@usr int,
	@uby int,
	@udate datetime,
	@lname varchar(50)
)
AS
UPDATE TECHNICIAN SET
	ULName = @lname,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


