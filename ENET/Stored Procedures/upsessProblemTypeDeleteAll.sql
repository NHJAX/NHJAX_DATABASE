CREATE PROCEDURE [dbo].[upsessProblemTypeDeleteAll]
(
	@tech int
)
AS
DELETE FROM sessPROBLEM_TYPE
WHERE CreatedBy = @tech
