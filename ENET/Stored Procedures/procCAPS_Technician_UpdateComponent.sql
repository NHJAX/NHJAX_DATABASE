create PROCEDURE [dbo].[procCAPS_Technician_UpdateComponent]
(
	@usr int,
	@uby int,
	@udate datetime,
	@cpt int
)
AS
UPDATE TECHNICIAN SET
	ComponentId = @cpt,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


