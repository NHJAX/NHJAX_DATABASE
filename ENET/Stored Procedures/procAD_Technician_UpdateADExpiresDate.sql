create PROCEDURE [dbo].[procAD_Technician_UpdateADExpiresDate]
(
	@exp		varchar(50),
	@login		varchar(256)
)
 AS

UPDATE TECHNICIAN
	SET ADExpiresDate = @exp,
	AutoUpdatedDate = getdate()
WHERE LoginId = @login



