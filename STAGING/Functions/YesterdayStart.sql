CREATE FUNCTION [dbo].[YesterdayStart](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @yesterdayStart datetime;
	SET 	@yesterdayStart = CONVERT(varchar(20), DATEADD(D, -1, @date), 101) + ' 00:00:00';
	RETURN @yesterdayStart;
END
