create PROCEDURE [dbo].[procENET_sessSYSTEM_TYPE_Delete]
(
	@sys int,
	@tech int
)
AS
DELETE FROM sessSYSTEM_TYPE
WHERE SystemTypeId = @sys
AND CreatedBy = @tech
