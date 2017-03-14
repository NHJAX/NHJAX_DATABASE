create PROCEDURE [dbo].[procCAPS_Technician_UpdateAltPhone]
(
	@usr int,
	@uby int,
	@udate datetime,
	@alt varchar(50)
)
AS
UPDATE TECHNICIAN SET
	AltPhone = @alt,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


