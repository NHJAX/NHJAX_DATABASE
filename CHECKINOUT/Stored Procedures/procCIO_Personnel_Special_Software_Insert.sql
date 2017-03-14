create PROCEDURE [dbo].[procCIO_Personnel_Special_Software_Insert]
(
@pers bigint, 
@aud  bigint
)
 AS

INSERT INTO PERSONNEL_SPECIAL_SOFTWARE
(
PersonnelId,
AudienceId
) 
VALUES(
@pers, 
@aud 
);



