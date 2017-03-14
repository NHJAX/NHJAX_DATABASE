CREATE PROCEDURE [dbo].[procCIO_Personnel_Type_List_Insert]
(
@pers bigint, 
@typ int
)
 AS

INSERT INTO PERSONNEL_TYPE_LIST
(
PersonnelId,
PersonnelTypeId
) 
VALUES(
@pers, 
@typ 
);



