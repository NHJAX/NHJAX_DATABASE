create PROCEDURE [dbo].[procCAPS_Technician_UpdateEducationLevel]
(
	@usr int,
	@uby int,
	@udate datetime,
	@edu int
)
AS
UPDATE TECHNICIAN SET
	EducationLevelId = @edu,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


