CREATE PROCEDURE [dbo].[procCAPS_Technician_UpdateEMail]
(
	@usr int,
	@uby int,
	@udate datetime,
	@email varchar(250)
)
AS
UPDATE TECHNICIAN SET
	EMailAddress = RTRIM(LTRIM(@email)),
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


