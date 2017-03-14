create PROCEDURE [dbo].[procCAPS_Technician_UpdateMedStuYr]
(
	@usr int,
	@uby int,
	@udate datetime,
	@med varchar(20)
)
AS
UPDATE TECHNICIAN SET
	MedStuYr = @med,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


