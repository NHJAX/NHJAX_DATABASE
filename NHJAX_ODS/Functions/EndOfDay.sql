
CREATE FUNCTION [dbo].[EndOfDay](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @endOfDay datetime;

	SET @endOfDay = CONVERT(varchar(20), @date, 101) + ' 23:59:59';

	RETURN @endOfDay;
END


