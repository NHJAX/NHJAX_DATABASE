CREATE FUNCTION [dbo].[PrevMonth](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @prevMonth datetime;
	SET 	@prevMonth = CONVERT(varchar(20), DATEADD(D, -60, @date), 101);
	RETURN @prevMonth;
END
