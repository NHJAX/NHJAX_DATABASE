CREATE PROCEDURE [dbo].[upsessProblemTypeSelectList]
(
	@tech int
)
 AS

SELECT PL.ProblemTypeId, 
	PROB.ProblemTypeDesc
FROM sessPROBLEM_TYPE PL
        	INNER JOIN PROBLEM_TYPE PROB
        	ON PL.ProblemTypeId = PROB.ProblemTypeId
WHERE PL.CreatedBy = @tech 
ORDER BY PROB.ProblemTypeDesc
