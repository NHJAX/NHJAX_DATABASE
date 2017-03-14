create FUNCTION [dbo].[FormatElapsedTime](@los int)
RETURNS varchar(5) AS  
BEGIN 

	DECLARE @hrs	varchar(2);
	DECLARE @min	varchar(2);
	DECLARE @smin	varchar(2);
	DECLARE @sdur	varchar(5);

	SET @hrs = CAST(FLOOR(@los/60) AS varchar(2));
	SET @min = @los % 60
	
	SET @smin = RIGHT('0' + CAST(@min AS varchar(2)), 2)

	SET @sdur = @hrs + ':' + @smin 
	
	RETURN @sdur
END

