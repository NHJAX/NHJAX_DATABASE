create PROCEDURE [dbo].[procENET_Personnel_Special_Software_Insert]
(
@usr int, 
@aud bigint
)
 AS

INSERT INTO PERSONNEL_SPECIAL_SOFTWARE
(
UserId,
AudienceId
) 
VALUES(
@usr, 
@aud 
);



