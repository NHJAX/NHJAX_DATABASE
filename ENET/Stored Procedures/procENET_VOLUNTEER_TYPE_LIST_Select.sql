
create PROCEDURE [dbo].[procENET_VOLUNTEER_TYPE_LIST_Select]
(
	@usr int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	VolunteerTypeId
FROM VOLUNTEER_TYPE_LIST
WHERE UserId = @usr

END

