create PROCEDURE [dbo].[procENET_Audience_Member_IsAudienceMember](
	@usr int,
	@aud bigint
)
 AS

SELECT     
	COUNT(AudienceMemberId) AS CountofMembership
FROM	AUDIENCE_MEMBER 
WHERE     TechnicianId = @usr
	AND AudienceId = @aud
