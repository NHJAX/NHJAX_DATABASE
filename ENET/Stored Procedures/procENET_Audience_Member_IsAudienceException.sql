create PROCEDURE [dbo].[procENET_Audience_Member_IsAudienceException]
(
	@aud bigint,
	@ex int
)
 AS

SELECT     
	COUNT(AudienceExceptionId) AS CountofExceptions
FROM	AUDIENCE_EXCEPTION
WHERE     (AudienceId = @aud) 
	AND (ApplicationExceptionId = @ex)
