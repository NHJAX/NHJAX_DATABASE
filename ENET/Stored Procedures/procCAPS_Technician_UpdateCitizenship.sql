create PROCEDURE [dbo].[procCAPS_Technician_UpdateCitizenship]
(
	@usr int,
	@uby int,
	@udate datetime,
	@cit int
)
AS
UPDATE TECHNICIAN SET
	CitizenshipId = @cit,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


