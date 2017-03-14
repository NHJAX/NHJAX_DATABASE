CREATE FUNCTION dbo.ToCompressedDateStr(@date datetime)
RETURNS varchar(15) AS  
BEGIN 
	DECLARE @century int
	DECLARE @dateStr varchar(15)
	SET @century = CAST(SUBSTRING(CAST(YEAR(@date) AS varchar(20)),1, 2) AS int)
	SET @dateStr = CAST(@century - 17 AS varchar(2)) + CONVERT(varchar(15), @date, 12)
	RETURN @dateStr 
END