create PROCEDURE [dbo].[procENET_Personnel_Type_List_Delete]
(
@usr int
)
 AS

DELETE FROM PERSONNEL_TYPE_LIST
WHERE UserId = @usr;




