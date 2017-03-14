create PROCEDURE [dbo].[procENET_Audience_Billet_IsDivisionOfficer]
(
	@usr int
)
 AS

SELECT     
	Count(AudienceMemberId)
FROM  AUDIENCE_MEMBER AS MEM
	INNER JOIN AUDIENCE_BILLET AS BIL
	ON MEM.BilletId = BIL.BilletId
WHERE BIL.AudienceId = 296
	AND MEM.TechnicianId = @usr
