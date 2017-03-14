CREATE FUNCTION [dbo].[AdmissionDateTime](@date varchar(16))
RETURNS datetime AS  
BEGIN 
	
	DECLARE @FormattedDate datetime;
	DECLARE @time varchar(5);
	if	ISDATE(@date) = 1
		SET @FormattedDate = CONVERT(DATETIME,@date)
	else
		BEGIN
			SET @time =  SUBSTRING(@date, LEN(@date) - 3, 2) + ':' + RIGHT(@date, 2)
			if @time = '24:00'
				SET @time = '00:00';
				SET @FormattedDate = CONVERT(DATETIME, LEFT(@date, 
                      			LEN(@date) - 5)) + CONVERT(DATETIME, @time);
		END
	/*
	SET @FormattedDate = CONVERT(DATETIME, LEFT(@date, 
                      LEN(@date) - 5)) + CONVERT(DATETIME, SUBSTRING(@date, LEN(@date) - 3, 
                      2) + ':' + RIGHT(@date, 2));
	*/
/*
	SET @NDCstring = RIGHT('00000000000' + CONVERT(varchar(11), CONVERT(bigint, @NDC)), 11);
	SET @RTstring = RIGHT(@NDCstring,2);
	SET @LTstring = LEFT(@NDCstring,5);
	SET @MIDstring = SUBSTRING(@NDCstring,6,4);
*/
	
	RETURN @FormattedDate;
END
