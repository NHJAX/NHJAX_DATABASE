CREATE PROCEDURE [dbo].[procENET_Audience_Member_Billet_SelectbyAudUser]
(
	@aud bigint,
	@usr int,
	@rol int
)
 AS

SELECT
	BIL.BilletId
FROM	AUDIENCE_BILLET AS BIL 
	INNER JOIN AUDIENCE_MEMBER AS MEM 
	ON BIL.BilletId = MEM.BilletId
WHERE (BIL.AudienceId = @rol) 
	AND (MEM.TechnicianId = @usr)
	AND (MEM.AudienceId = @aud)
