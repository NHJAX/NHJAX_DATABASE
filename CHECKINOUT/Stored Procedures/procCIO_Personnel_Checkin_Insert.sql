create PROCEDURE [dbo].[procCIO_Personnel_Checkin_Insert]
(
@pers bigint, 
@aud bigint
)
 AS

INSERT INTO PERSONNEL_CHECKIN
(
PersonnelId,
AudienceId
) 
VALUES(
@pers, 
@aud 
);



