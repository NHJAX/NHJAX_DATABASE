CREATE FUNCTION [dbo].[CountProblemType](@tech int)
RETURNS int AS  
BEGIN 
	
	DECLARE @ucnt int

	SELECT @ucnt = COUNT(ProblemTypeId) 
	FROM sessPROBLEM_TYPE
	WHERE CreatedBy = @tech

	return @ucnt;
END
