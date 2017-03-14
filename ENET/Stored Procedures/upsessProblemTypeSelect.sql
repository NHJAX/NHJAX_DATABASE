CREATE PROCEDURE [dbo].[upsessProblemTypeSelect]
(
	@tech int
)
AS
SELECT PT.ProblemTypeId,
	PT.ProblemTypeDesc
FROM PROBLEM_TYPE PT
WHERE PT.ProblemTypeId NOT IN (
	SELECT sessPROBLEM_TYPE.ProblemTypeId
	FROM sessPROBLEM_TYPE
	WHERE sessPROBLEM_TYPE.CreatedBy = @tech)
ORDER BY PT.ProblemTypeDesc
