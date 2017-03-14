create PROCEDURE [dbo].[procCAPS_Technician_UpdateCity]
(
	@usr int,
	@uby int,
	@udate datetime,
	@city varchar(50)
)
AS
UPDATE TECHNICIAN SET
	City = @city,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


