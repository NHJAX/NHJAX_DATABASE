create PROCEDURE [dbo].[procCAPS_Technician_UpdateDesignation]
(
	@usr int,
	@uby int,
	@udate datetime,
	@des int
)
AS
UPDATE TECHNICIAN SET
	Designationid = @des,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


