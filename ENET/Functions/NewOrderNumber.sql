CREATE FUNCTION [dbo].[NewOrderNumber](@base varchar(5),@today datetime, @user int)
RETURNS nvarchar(50) AS  
BEGIN 
	
	DECLARE @year varchar(4)
	DECLARE @month varchar(2)
	DECLARE @day varchar(2)
	DECLARE @hour varchar(2)
	DECLARE @min varchar(2)
	DECLARE @userString varchar(11)

	SET @year = RIGHT('0000' + CAST(YEAR(@today) AS varchar(4)),4)
	SET @month = RIGHT('00' + CAST(MONTH(@today) AS varchar(2)),2)
	SET @day = RIGHT('00' + CAST(DAY(@today) AS varchar(2)),2)
	SET @hour = RIGHT('00' + CAST(DATEPART(hh,@today) AS varchar(2)),2)
	SET @min = RIGHT('00' + CAST(DATEPART(n,@today) AS varchar(2)),2)

	SET @userString = CAST(@user AS varchar(11))

	return @userString + @base + @year + @month + @day + @hour + @min
END








