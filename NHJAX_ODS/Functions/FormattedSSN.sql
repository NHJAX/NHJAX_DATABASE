
CREATE FUNCTION [dbo].[FormattedSSN]
(@SSN varchar(255))
RETURNS varchar(11) AS  
BEGIN 
	DECLARE @SSNstring varchar(9);
	DECLARE @LTstring varchar(3);
	DECLARE @MIDstring varchar(2);
	DECLARE @RTstring varchar(4);
	DECLARE @FormattedString varchar(11)

	--If Len < 9
	IF DataLength(@SSN) < 9
		BEGIN
			SET @SSNstring = RIGHT('000000000' + CONVERT(varchar(9), CONVERT(bigint, @SSN)), 9);
			SET @LTstring = LEFT(@SSNstring,3);
			SET @MIDstring = SUBSTRING(@SSNstring,4,2);
			SET @RTstring = RIGHT(@SSNstring,4);

			SET @FormattedString = @LTstring + '-' + @MIDstring + '-' + @RTstring;		
		END
	ELSE IF DataLength(@SSN) = 9
		BEGIN
			SET @LTstring = LEFT(@SSN,3);
			SET @MIDstring = SUBSTRING(@SSN,4,2);
			SET @RTstring = RIGHT(@SSN,4);

			SET @FormattedString = @LTstring + '-' + @MIDstring + '-' + @RTstring;
		END
	ELSE
		BEGIN
			SET @FormattedString = @SSN
		END
	
	RETURN @FormattedString;
	--RETURN @SSNString;
	--RETURN @RTstring;
	--RETURN @SSN;
END



