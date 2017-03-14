CREATE FUNCTION [dbo].[MilitaryTime](@date datetime)
RETURNS varchar(4) AS  
BEGIN 
	DECLARE @Hourstring varchar(2);
	DECLARE @Minutestring varchar(2);
	DECLARE @FormattedString varchar(4);

	SET @Hourstring = RIGHT('00' + CONVERT(varchar(2), { fn HOUR(@date)}),2);
	SET @Minutestring = RIGHT('00' + CONVERT(varchar(2), {fn MINUTE(@date)}),2);

/*
	SET @NDCstring = RIGHT('00000000000' + CONVERT(varchar(11), CONVERT(bigint, @NDC)), 11);
	SET @RTstring = RIGHT(@NDCstring,2);
	SET @LTstring = LEFT(@NDCstring,5);
	SET @MIDstring = SUBSTRING(@NDCstring,6,4);
*/

	SET @FormattedString = @Hourstring + @Minutestring;

	RETURN @FormattedString;
END
