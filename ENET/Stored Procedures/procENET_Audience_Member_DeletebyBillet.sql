create PROCEDURE [dbo].[procENET_Audience_Member_DeletebyBillet]
(
@bil int,
@aud bigint,
@usr int
)
 AS

DELETE FROM AUDIENCE_MEMBER
WHERE BilletId = @bil
AND AudienceId = @aud
AND TechnicianId = @usr;




