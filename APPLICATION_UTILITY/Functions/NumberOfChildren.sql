-- =============================================
-- Author:		Robert Evans
-- Create date: 7 Aug 2015
-- Description:	Gets the Number Of Children for a given MenuItemId
-- =============================================
CREATE FUNCTION NumberOfChildren 
(
	@MenuItemId int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar int = 0

	-- Add the T-SQL statements to compute the return value here
	IF EXISTS(SELECT *  FROM [MENU_ITEMS] WHERE ParentItemId = @MenuItemId)
	BEGIN
		SELECT @ResultVar = COUNT(*)  FROM [MENU_ITEMS] WHERE ParentItemId = @MenuItemId
	END
	-- Return the result of the function
	RETURN @ResultVar

END
