create PROCEDURE [dbo].[procAD_Technician_UpdateADLoginDate]
(
	@log		varchar(50),
	@login		varchar(256)
)
 AS

UPDATE TECHNICIAN
	SET ADLoginDate = @log,
	AutoUpdatedDate = getdate()
WHERE LoginId = @login



