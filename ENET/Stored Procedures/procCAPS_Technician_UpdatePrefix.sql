create PROCEDURE [dbo].[procCAPS_Technician_UpdatePrefix]
(
	@usr int,
	@uby int,
	@udate datetime,
	@pre varchar(10)
)
AS
UPDATE TECHNICIAN SET
	Prefix = @pre,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


