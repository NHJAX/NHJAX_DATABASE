create PROCEDURE [dbo].[procENET_sessSYSTEM_TYPE_DeleteAll]
(
	@tech int
)
AS
DELETE FROM sessSYSTEM_TYPE
WHERE CreatedBy = @tech
