CREATE PROCEDURE [dbo].[procENET_Audience_Member_IsDepartmentHead](
	@usr int
)
 AS

SELECT     
	COUNT(BIL.AudienceId) AS CountofAudience
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN AUDIENCE_BILLET AS BIL 
	ON MEM.BilletId = BIL.BilletId
WHERE     (MEM.TechnicianId = @usr) 
	AND (BIL.AudienceId = 77)
	AND (BIL.BilletId <> 0)
