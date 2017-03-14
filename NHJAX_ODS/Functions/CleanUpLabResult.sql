-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION CleanUpLabResult 
(
	-- Add the parameters for the function here
	@DirtyResult nchar(19)
)
RETURNS nchar(19)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar nchar(19)

	SET @ResultVar = REPLACE(@DirtyResult,'=','')
	SET @ResultVar = REPLACE(@ResultVar,'.','')
	SET @ResultVar = REPLACE(@ResultVar,'<','')
	SET @ResultVar = REPLACE(@ResultVar,'>','')
	SET @ResultVar = REPLACE(@ResultVar,'"','')
	SET @ResultVar = REPLACE(@ResultVar,'?','')
	-- Return the result of the function
	RETURN @ResultVar

END
