CREATE FUNCTION [dbo].[Todeersdate](@deersDate varchar(15))
RETURNS datetime AS  
BEGIN 
	
	DECLARE @dateStr datetime
	IF @deersDate = 'INDEFINITE'
		SET @dateStr = CAST('12/31/9999' AS datetime)
	ELSE IF @deersDate IS NULL OR ISDATE(@deersDate) = 0
		SET @dateStr = CAST('1/1/1753' AS datetime) 
	ELSE
		SET @dateStr = CAST(@deersDate AS datetime)
	Return @dateStr
END
