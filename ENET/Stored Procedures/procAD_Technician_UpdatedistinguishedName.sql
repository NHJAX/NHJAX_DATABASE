CREATE PROCEDURE [dbo].[procAD_Technician_UpdatedistinguishedName]
(
	@name		varchar(255),
	@login		varchar(256)
)
 AS

UPDATE TECHNICIAN
	SET distinguishedName = @name,
	AutoUpdatedDate = getdate()
WHERE LoginId = @login



