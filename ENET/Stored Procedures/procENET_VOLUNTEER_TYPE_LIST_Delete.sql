create PROCEDURE [dbo].[procENET_VOLUNTEER_TYPE_LIST_Delete]
(
@usr int
)
 AS

DELETE FROM VOLUNTEER_TYPE_LIST
WHERE UserId = @usr;




