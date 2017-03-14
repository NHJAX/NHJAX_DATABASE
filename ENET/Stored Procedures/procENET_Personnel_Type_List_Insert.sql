create PROCEDURE [dbo].[procENET_Personnel_Type_List_Insert]
(
@usr int, 
@typ int
)
 AS

INSERT INTO PERSONNEL_TYPE_LIST
(
UserId,
PersonnelTypeId
) 
VALUES(
@usr, 
@typ 
);



