CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateComments]
(
	@usr int,
	@uby int,
	@udate datetime,
	@com varchar(8000)
)
AS
UPDATE TECHNICIAN SET
	Comments = @com,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


