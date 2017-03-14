CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectLeaveRouting20130308]
(
	@usr int,
	@aud bigint
)
 AS

SELECT
	GRP.AudienceId, 
	AUD.DisplayName
FROM AUDIENCE_GROUP AS GRP 
	INNER JOIN AUDIENCE AS AUD 
	ON GRP.AudienceId = AUD.AudienceId 
	INNER JOIN AUDIENCE_EXCEPTION AS EXC 
	ON GRP.AudienceId = EXC.AudienceId
WHERE ((GRP.GroupId = 29) 
	AND (EXC.ApplicationExceptionId = 4)
	AND (GRP.IsLeaveAlternate = 0) 
	AND (GRP.AudienceId NOT IN
		(
		SELECT MEM.AudienceId
		FROM AUDIENCE_MEMBER AS MEM 
			INNER JOIN AUDIENCE_GROUP AS GRP 
			ON GRP.AudienceId = MEM.AudienceId 
			INNER JOIN AUDIENCE AS AUD 
			ON MEM.AudienceId = AUD.AudienceId
		WHERE (GRP.GroupId = 29) 
			AND (MEM.TechnicianId = @usr) 
			AND (GRP.AudienceCategoryId IN (5, 6))
		UNION
		SELECT BIL.AudienceId
		FROM AUDIENCE_GROUP AS GRP 
			INNER JOIN AUDIENCE_BILLET AS BIL 
			ON GRP.AudienceId = BIL.AudienceId 
			INNER JOIN AUDIENCE_MEMBER AS MEM 
			ON BIL.BilletId = MEM.BilletId 
			INNER JOIN AUDIENCE AS AUD 
			ON BIL.AudienceId = AUD.AudienceId
		WHERE (GRP.GroupId = 29) 
			AND (MEM.TechnicianId = @usr) 
			AND (MEM.AudienceId = @aud)
			AND (MEM.BilletId NOT IN(3,4,5,14,301))
		))
	AND (GRP.FlowStep >
		(
		SELECT MaxLeaveStep
		FROM vwLEAVE_MAX_FLOW_STEP
		WHERE (TechnicianId = @usr))
		))
	OR GRP.AudienceId = 297
ORDER BY GRP.FlowStep
