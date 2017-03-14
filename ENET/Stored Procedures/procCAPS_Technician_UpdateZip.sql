create PROCEDURE [dbo].[procCAPS_Technician_UpdateZip]
(
	@usr int,
	@uby int,
	@udate datetime,
	@zip varchar(10)
)
AS
UPDATE TECHNICIAN SET
	Zip = @zip,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


