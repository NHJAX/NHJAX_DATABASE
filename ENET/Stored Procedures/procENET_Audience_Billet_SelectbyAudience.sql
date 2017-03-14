CREATE PROCEDURE [dbo].[procENET_Audience_Billet_SelectbyAudience](
	@aud bigint
)
 AS

SELECT     
	AUDIENCE_BILLET.AudienceBilletId, 
	AUDIENCE_BILLET.AudienceId, 
	AUDIENCE_BILLET.BilletId, 
	BILLET.BilletShortName, 
	BILLET.BilletDesc
FROM	AUDIENCE_BILLET 
	INNER JOIN BILLET 
	ON AUDIENCE_BILLET.BilletId = BILLET.BilletId
WHERE AUDIENCE_BILLET.AudienceId = @aud
ORDER BY AUDIENCE_BILLET.BilletId
