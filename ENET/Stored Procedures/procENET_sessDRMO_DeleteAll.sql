create PROCEDURE [dbo].[procENET_sessDRMO_DeleteAll]
(
	@usr int
)
 AS

DELETE FROM sessDRMO
WHERE CreatedBy = @usr
