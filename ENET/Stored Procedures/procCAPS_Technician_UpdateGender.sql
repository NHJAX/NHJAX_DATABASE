create PROCEDURE [dbo].[procCAPS_Technician_UpdateGender]
(
	@usr int,
	@uby int,
	@udate datetime,
	@sex varchar(1)
)
AS
UPDATE TECHNICIAN SET
	Sex = @sex,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


