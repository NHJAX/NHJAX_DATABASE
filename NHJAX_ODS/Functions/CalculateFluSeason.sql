
CREATE FUNCTION [dbo].[CalculateFluSeason](@date datetime)
RETURNS varchar(4) AS  
BEGIN 

	DECLARE @startdate VARCHAR(10)
	,@enddate VARCHAR(10)
	,@result varchar(4)	
	
	SET @startdate = '1/1/' + CAST(DATEPART(YYYY,@date)  AS VARCHAR(10));
	SET @enddate = '6/30/' + CAST(DATEPART(YYYY,@date) AS VARCHAR(10));
	
	set @result = case when @date >=  cast(@startdate as datetime) and @date <= cast(@enddate as datetime) then DATEPART(YYYY,@startdate)-1 else DATEPART(YYYY,@startdate) end
	
	RETURN @result;
END


