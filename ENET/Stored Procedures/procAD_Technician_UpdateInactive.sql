create PROCEDURE [dbo].[procAD_Technician_UpdateInactive]
(
	@inac		bit,
	@login		varchar(256)
)
 AS

UPDATE TECHNICIAN
	SET Inactive = @inac,
	AutoUpdatedDate = getdate()
WHERE LoginId = @login



