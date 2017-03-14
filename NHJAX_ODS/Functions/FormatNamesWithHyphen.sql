

create FUNCTION [dbo].[FormatNamesWithHyphen]
(
	@nametofix nvarchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @fixedname nvarchar(50)
	
		set @fixedname = replace(@nametofix, '''', '')
	select @fixedname = replace(@fixedname, '-','')	
	
	RETURN @fixedname

END

