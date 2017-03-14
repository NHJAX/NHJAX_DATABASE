CREATE FUNCTION [dbo].[StartOfDay](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @startOfDay	datetime;
	SET @startOfDay = CONVERT(varchar(20), @date, 101) + ' 00:00:00';
	RETURN @startOfDay;
END
