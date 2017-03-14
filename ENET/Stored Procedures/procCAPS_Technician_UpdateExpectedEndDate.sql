create PROCEDURE [dbo].[procCAPS_Technician_UpdateExpectedEndDate]
(
	@usr int,
	@uby int,
	@udate datetime,
	@ee datetime
)
AS
UPDATE TECHNICIAN SET
	ExpectedEndDate = @ee,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


