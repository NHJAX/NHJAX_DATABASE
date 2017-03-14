create FUNCTION [dbo].[CountSystemType](@tech int)
RETURNS int AS  
BEGIN 
	
	DECLARE @ucnt int

	SELECT @ucnt = COUNT(SystemTypeId) 
	FROM sessSYSTEM_TYPE
	WHERE CreatedBy = @tech

	return @ucnt;
END
