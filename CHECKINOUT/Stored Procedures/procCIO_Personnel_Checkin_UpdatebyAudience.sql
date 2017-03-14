CREATE PROCEDURE [dbo].[procCIO_Personnel_Checkin_UpdatebyAudience]
(
@pers bigint,
@aud bigint, 
@stat int,
@usr int
)
 AS

UPDATE PERSONNEL_CHECKIN
SET CheckinStatusId = @stat,
UpdatedBy = @usr,
UpdatedDate = getdate()
WHERE PersonnelId = @pers
AND AudienceId = @aud;



