CREATE PROCEDURE [dbo].[procENET_Audience_Member_IsDirectorateHead](
	@usr int
)
 AS

SELECT     
	COUNT(BIL.AudienceId) AS CountofAudience
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN AUDIENCE_BILLET AS BIL 
	ON MEM.BilletId = BIL.BilletId
WHERE     (MEM.TechnicianId = @usr) 
	AND (BIL.AudienceId = 76)
	AND (BIL.BilletId <> 0)
