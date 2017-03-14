CREATE FUNCTION [dbo].[ToRecordGroup](@days int)
RETURNS varchar(20) AS  
BEGIN 
	DECLARE @range varchar(20);
	IF @days < 10 
		SET @range = '< 10 Days'
	ELSE IF @days >= 10 AND @days <= 19
		SET @range = '10 - 19 Days'
	ELSE IF @days >=20 AND @days <= 29
		SET @range = '20 - 29 Days'
	ELSE IF @days >= 30 AND @days <= 39
		SET @range = '30 - 39 Days'
	ELSE IF @days > 39
		SET @range = '40+ Days'
	RETURN @range;
			
END
