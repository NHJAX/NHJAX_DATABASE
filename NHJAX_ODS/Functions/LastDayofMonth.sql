CREATE FUNCTION [dbo].[LastDayofMonth](@date datetime)
RETURNS datetime AS  
BEGIN 
	DECLARE @fdom	datetime;
	DECLARE @smth varchar(2)
	DECLARE @syr varchar(4)
	DECLARE @strf varchar(10)
	SET @smth = CAST(Month(DATEADD(Month,1,@date))as varchar(2))
	SET @syr = CAST(Year(DATEADD(Month,1,@date))as varchar(4))
	SET @strf = @smth + '/1/' + @syr
	SET @fdom = CONVERT(varchar(20),@strf, 101) + ' 23:59:59';
	SET @fdom = DATEADD(d,-1,@fdom)
	RETURN @fdom;
END
