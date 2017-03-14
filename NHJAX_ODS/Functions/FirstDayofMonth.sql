CREATE FUNCTION [dbo].[FirstDayofMonth](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @fdom	datetime;
	DECLARE @smth varchar(2)
	DECLARE @syr varchar(4)
	SET @smth = CAST(Month(@date) as varchar(2))
	SET @syr = CAST(Year(@date)as varchar(4))
	SET @fdom = CONVERT(varchar(20),@smth + '/1/' + @syr, 101) + ' 00:00:00';
	RETURN @fdom;
END
