create PROCEDURE [dbo].[procCIO_Personnel_Checkin_Count]
(
@pers bigint, 
@aud bigint
)
 AS

SELECT     
	COUNT(PersonnelCheckinId)
FROM PERSONNEL_CHECKIN
WHERE (AudienceId = @aud) 
	AND (PersonnelId = @pers);



