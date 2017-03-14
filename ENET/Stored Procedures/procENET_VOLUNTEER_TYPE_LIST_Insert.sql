create PROCEDURE [dbo].[procENET_VOLUNTEER_TYPE_LIST_Insert]
(
@usr int, 
@typ int
)
 AS

INSERT INTO VOLUNTEER_TYPE_LIST
(
UserId,
VolunteerTypeId
) 
VALUES(
@usr, 
@typ 
);



