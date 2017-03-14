CREATE PROCEDURE [dbo].[procENET_Audience_Member_HasCommandAccess](
	@usr int
)
 AS

SELECT     
	COUNT(BIL.AudienceId) AS CountofAudience
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN AUDIENCE_BILLET AS BIL 
	ON MEM.BilletId = BIL.BilletId
WHERE     (MEM.TechnicianId = @usr) 
	AND (BIL.AudienceId = 273)
	AND (BIL.BilletId <> 0)
