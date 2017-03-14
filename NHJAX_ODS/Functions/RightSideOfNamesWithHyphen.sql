

create FUNCTION [dbo].[RightSideOfNamesWithHyphen]
(
	@nametofix nvarchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @fixedname nvarchar(50)
			,@hyphen int
	
	set @hyphen = charindex('-',@nametofix)

	select @fixedname = right(@nametofix,  len(@nametofix) - (@hyphen))
		
	RETURN @fixedname

END

