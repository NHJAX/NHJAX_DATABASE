
CREATE FUNCTION [dbo].[FormatDateWithoutTime]
(
	@date datetime,
	@format int = 1
)
returns varchar(10) as 
BEGIN
	-- Declare the return variable here
	DECLARE @MO varchar(2);
	DECLARE @DAY varchar(2);
	DECLARE @YR varchar(4);
	DECLARE @Result varchar(10);
	DECLARE @mth varchar(2);


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
ELSE IF (@format = 3)
BEGIN
	SET @mth = RIGHT('00' + @mo, 2)
	set @result = @yr + '-' + @mth
END

	RETURN @result;

END
