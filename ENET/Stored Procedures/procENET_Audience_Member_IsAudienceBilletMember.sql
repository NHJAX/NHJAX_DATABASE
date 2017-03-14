Create PROCEDURE [dbo].[procENET_Audience_Member_IsAudienceBilletMember]
(
	@usr int,
	@aud bigint
)
 AS

SELECT     
	COUNT(MEM.AudienceMemberId) AS CountofMembership
FROM         
	AUDIENCE_BILLET AS AB 
	INNER JOIN AUDIENCE_MEMBER AS MEM 
	ON AB.BilletId = MEM.BilletId
WHERE     
	(MEM.TechnicianId = @usr) 
	AND (AB.AudienceId = @aud) 
	AND (AB.BilletId > 0)

