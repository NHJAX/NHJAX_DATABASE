
create PROCEDURE [dbo].[procENET_TECHNICIAN_Security_Level_Delete]
(
	@usr int
) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DELETE FROM TECHNICIAN_SECURITY_LEVEL
WHERE UserId = @usr


END

