CREATE FUNCTION [dbo].[FormatDuration](@dur decimal(11,2))
RETURNS varchar(8) AS  
BEGIN 

	DECLARE @hrs	varchar(5);
	DECLARE @min	varchar(3);
	DECLARE @smin	varchar(3);
	DECLARE @sdur	varchar(8);

	SET @hrs = CAST(FLOOR(@dur/60) AS varchar(5));
	SET @min = CAST(SUBSTRING(CAST(@dur/60 AS varchar(20)),CHARINDEX('.',@dur/60) , 3) AS varchar(3));
	
	SET @smin = CAST(ROUND(CAST(@min AS decimal(2,2)) * 60,0) AS int)
	SET @smin = RIGHT('0' + CAST(@smin AS varchar(2)), 2)

	SET @sdur = @hrs + ':' + @smin 
	
	RETURN @sdur
END

/*
Local numberVar hrs := Truncate(Average ({ER_EOD_Summary.Duration}, {ER_EOD_Summary.CheckIn}, "daily")/60);
Local numberVar min := Remainder(Average ({ER_EOD_Summary.Duration}, {ER_EOD_Summary.CheckIn}, "daily"), 60);
Local stringVar shrs;
Local stringVar smin;
shrs := CStr(hrs, 0);
smin := CStr(min, 0);
if Length(smin) = 1 then
    smin := "0" + smin;
    
shrs + ":" + smin
*/