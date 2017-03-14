create FUNCTION [dbo].[CountTechList](@tech int)
RETURNS int AS  
BEGIN 
	
	DECLARE @ucnt int

	SELECT @ucnt = COUNT(UserId) 
	FROM sessTECH_LIST
	WHERE CreatedBy = @tech

	return @ucnt;
END
