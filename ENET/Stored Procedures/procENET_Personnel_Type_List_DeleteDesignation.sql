create PROCEDURE [dbo].[procENET_Personnel_Type_List_DeleteDesignation]
(
@usr int
)
 AS

DELETE FROM PERSONNEL_TYPE_LIST
WHERE UserId = @usr
AND PersonnelTypeId IN (1,15);




