CREATE FUNCTION [dbo].[FormattedNDC](@NDC numeric(21,3))
RETURNS varchar(13) AS  
BEGIN 
	DECLARE @NDCstring varchar(11);
	DECLARE @RTstring varchar(2);
	DECLARE @LTstring varchar(5);
	DECLARE @MIDstring varchar(4);
	DECLARE @FormattedString varchar(13)
	SET @NDCstring = RIGHT('00000000000' + CONVERT(varchar(11), CONVERT(bigint, @NDC)), 11);
	SET @RTstring = RIGHT(@NDCstring,2);
	SET @LTstring = LEFT(@NDCstring,5);
	SET @MIDstring = SUBSTRING(@NDCstring,6,4);
	SET @FormattedString = @LTstring + '-' + @MIDstring + '-' + @RTstring;
	RETURN @FormattedString;
END
