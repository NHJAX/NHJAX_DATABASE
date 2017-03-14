CREATE FUNCTION [dbo].[RecordLocation](@RL varchar(64))
RETURNS numeric(12,4) AS  
BEGIN 
/*
	DECLARE @NDCstring varchar(11);
	DECLARE @RTstring varchar(2);
	DECLARE @LTstring varchar(5);
	DECLARE @MIDstring varchar(4);
	DECLARE @FormattedString varchar(13)
	SET @NDCstring = RIGHT('00000000000' + CONVERT(varchar(11), CONVERT(bigint, @RL)), 11);
	SET @RTstring = RIGHT(@NDCstring,2);
	SET @LTstring = LEFT(@NDCstring,5);
	SET @MIDstring = SUBSTRING(@NDCstring,6,4);
	SET @FormattedString = @LTstring + '-' + @MIDstring + '-' + @RTstring;
*/
	DECLARE @Location numeric(12,4)
	IF ISNUMERIC(@RL) = 0
		BEGIN
			SET @Location = 0
		END
	ELSE
		BEGIN
			SET @Location = CONVERT(numeric(12,4),@RL)
		END
		
	RETURN @Location;
END
