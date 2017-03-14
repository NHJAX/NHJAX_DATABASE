create PROCEDURE [dbo].[procCIO_Personnel_Type_List_Delete]
(
@pers bigint
)
 AS

DELETE FROM PERSONNEL_TYPE_LIST
WHERE PersonnelId = @pers;



