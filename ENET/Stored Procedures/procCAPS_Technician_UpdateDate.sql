CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateDate]
(
	@usr int,
	@uby int,
	@udate datetime
)
AS
UPDATE TECHNICIAN SET
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;
