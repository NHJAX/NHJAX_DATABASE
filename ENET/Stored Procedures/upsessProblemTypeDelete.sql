CREATE PROCEDURE [dbo].[upsessProblemTypeDelete]
(
	@prob int,
	@tech int
)
AS
DELETE FROM sessPROBLEM_TYPE
WHERE ProblemTypeId = @prob
AND CreatedBy = @tech
