
CREATE FUNCTION [dbo].[FormatTime](@date datetime)
RETURNS varchar(5) AS  
BEGIN 
	
	DECLARE @hour varchar(2)
	DECLARE @minute varchar(2)
	
	SET @hour = DATEPART(hh,@date)
	SET @minute = DATEPART(n,@date)

	return @hour + ':' + @minute;
END

