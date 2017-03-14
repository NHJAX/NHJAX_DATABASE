create PROCEDURE [dbo].[procCAPS_Technician_UpdateNMCIEmail]
(
	@usr int,
	@uby int,
	@udate datetime,
	@nmci varchar(100)
)
AS
UPDATE TECHNICIAN SET
	NMCIEMail = @nmci,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


