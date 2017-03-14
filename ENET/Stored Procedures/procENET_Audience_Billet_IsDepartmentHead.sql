create PROCEDURE [dbo].[procENET_Audience_Billet_IsDepartmentHead]
(
	@usr int
)
 AS

SELECT     
	Count(AudienceMemberId)
FROM  AUDIENCE_MEMBER AS MEM
	INNER JOIN AUDIENCE_BILLET AS BIL
	ON MEM.BilletId = BIL.BilletId
WHERE BIL.AudienceId = 77
	AND MEM.TechnicianId = @usr
