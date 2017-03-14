
CREATE FUNCTION [dbo].[FormatDateWithoutTime]
(
	@date datetime,
	@format int = 1
)
returns varchar(11) as 
BEGIN
	-- Declare the return variable here
	DECLARE @MO varchar(2);
	DECLARE @DAY varchar(2);
	DECLARE @YR varchar(4);
	DECLARE @Result varchar(11);
	DECLARE @sMO varchar(3);


Set @mo = convert(varchar(2),DATEPART(mm, @date))
set @day = convert(varchar(2), DATEPART(dd, @date))
set @YR = convert(varchar(4), DATEPART(yyyy,@date))

	-- Return the result of the function
IF(@format = 1)
	BEGIN
	set @result = @yr + '-' + @MO + '-' + @day
	END
ELSE IF(@format = 2)
BEGIN
	set @result = @MO + '/' + @day + '/' + @yr
END
ELSE IF(@format = 3)
BEGIN
	IF @MO = 1 
		SET @sMO = 'Jan'
	ELSE If @MO = 2
		SET @sMO = 'Feb'
	ELSE If @MO = 3
		SET @sMO = 'Mar'
	ELSE If @MO = 4
		SET @sMO = 'Apr'
	ELSE If @MO = 5
		SET @sMO = 'May'
	ELSE If @MO = 6
		SET @sMO = 'Jun'
	ELSE If @MO = 7
		SET @sMO = 'Jul'
	ELSE If @MO = 8
		SET @sMO = 'Aug'
	ELSE If @MO = 9
		SET @sMO = 'Sep'
	ELSE If @MO = 10
		SET @sMO = 'Oct'
	ELSE If @MO = 11
		SET @sMO = 'Nov'
	ELSE If @MO = 12
		SET @sMO = 'Dec'
					
	set @result = @day + ' ' + @sMO + ' ' + @yr
	
	
END

	RETURN @result;

END
