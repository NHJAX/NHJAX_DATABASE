CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateEAOS]
(
	@usr int,
	@uby int,
	@udate datetime,
	@ep datetime
)
AS
UPDATE TECHNICIAN SET
	EAOS_PRD = @ep,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


