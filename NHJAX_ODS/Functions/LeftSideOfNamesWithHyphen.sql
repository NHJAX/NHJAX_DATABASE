

CREATE FUNCTION [dbo].[LeftSideOfNamesWithHyphen]
(
	@nametofix nvarchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @fixedname nvarchar(50)
			,@hyphen int
			,@apost int
	
	set @hyphen = charindex('-',@nametofix)
	set @apost = charindex('''',@nametofix)
	
	if (@hyphen > 0)
		BEGIN
			SET @fixedname = REPLACE(@nametofix, '''','')
			IF (@apost > 0)
				BEGIN
					SELECT @fixedname = left(@fixedname, @hyphen-2)
				END
			ELSE
				BEGIN
					SELECT @fixedname = left(@fixedname, @hyphen-1)
				END
		END
	ELSE
		BEGIN
			SELECT @fixedname = @nametofix
		END
	RETURN @fixedname

END

