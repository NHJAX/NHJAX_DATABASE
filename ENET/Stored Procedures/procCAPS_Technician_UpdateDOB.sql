create PROCEDURE [dbo].[procCAPS_Technician_UpdateDOB]
(
	@usr int,
	@uby int,
	@udate datetime,
	@dob datetime
)
AS
UPDATE TECHNICIAN SET
	DOB = @dob,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


