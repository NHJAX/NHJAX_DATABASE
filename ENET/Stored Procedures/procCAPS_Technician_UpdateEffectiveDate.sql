create PROCEDURE [dbo].[procCAPS_Technician_UpdateEffectiveDate]
(
	@usr int,
	@uby int,
	@udate datetime,
	@eff datetime
)
AS
UPDATE TECHNICIAN SET
	EffectiveDate = @eff,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


