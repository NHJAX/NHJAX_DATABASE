create PROCEDURE [dbo].[procAD_Technician_UpdateAudiencebyLogin]
(
	@aud		bigint,
	@login		varchar(256)
)
 AS

UPDATE TECHNICIAN
	SET AudienceId = @aud,
	AutoUpdatedDate = getdate()
WHERE LoginId = @login



