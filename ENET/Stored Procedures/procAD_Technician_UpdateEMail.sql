create PROCEDURE [dbo].[procAD_Technician_UpdateEMail]
(
	@email		varchar(100),
	@login		varchar(256)
)
 AS

UPDATE TECHNICIAN
	SET EMailAddress = @email,
	AutoUpdatedDate = getdate()
WHERE LoginId = @login



