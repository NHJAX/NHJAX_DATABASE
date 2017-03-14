CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectbyOwnerMID](
	@usr int
)
 AS

SELECT     
	count(MEM.AudienceMemberId)
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN AUDIENCE_GROUP AS GRP 
	ON GRP.AudienceId = MEM.AudienceId
WHERE	(GRP.AudienceId IN (245,249,429))
AND	MEM.TechnicianId = @usr
AND GRP.AudienceCategoryId = 6



