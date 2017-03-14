CREATE FUNCTION [dbo].[YesterdayEnd](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @yesterdayEnd datetime;
	SET 	@yesterdayEnd = CONVERT(varchar(20), DATEADD(D, -1, @date), 101) + ' 23:59:59';
	RETURN @yesterdayEnd;
END
