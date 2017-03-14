create PROCEDURE [dbo].[procENET_sessDRMO_Delete]
(
	@drmo int
)
 AS

DELETE FROM sessDRMO
WHERE DRMOId = @drmo
