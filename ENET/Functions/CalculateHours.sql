create FUNCTION [dbo].[CalculateHours](@hours int, @typ int)
RETURNS decimal(5,2) AS  
BEGIN 
	
	DECLARE @calc decimal(5,2)
	
	IF @typ = 2
	BEGIN
	SET @calc = @hours/24
	END
	ELSE
	BEGIN
	SET @calc = @hours/8
	END


	return @calc;
END
