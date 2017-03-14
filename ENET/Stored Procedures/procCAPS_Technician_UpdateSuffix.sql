Create PROCEDURE [dbo].[procCAPS_Technician_UpdateSuffix]
(
	@usr int,
	@uby int,
	@udate datetime,
	@sufx varchar(6)
)
AS
UPDATE TECHNICIAN SET
	Suffix = @sufx,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


