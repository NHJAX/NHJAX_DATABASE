CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectbyAppUserAud](
	@usr int,
	@grp int,
	@aud bigint
)
 AS

SELECT
	MEM.AudienceMemberId,     
	MEM.AudienceId, 
	GRP.FlowStep, 
	AUD.DisplayName, 
	@usr AS UserId,
	0 AS IsSubGroup,
	0 AS AudienceGroup,
	0 AS BilletId,
	GRP.SendToMember,
	GRP.IsRestrictedGroup
FROM	AUDIENCE_MEMBER AS MEM 
	INNER JOIN AUDIENCE_GROUP AS GRP 
	ON GRP.AudienceId = MEM.AudienceId
	INNER JOIN AUDIENCE AS AUD
	ON MEM.AudienceId = AUD.AudienceId
WHERE	(GRP.GroupId = @grp) 
	AND (MEM.TechnicianId = @usr) 
	--AND (GRP.AudienceCategoryId IN (5,6))

UNION

SELECT 
	MEM.AudienceMemberId, 
	MEM.AudienceId, 
	GRP.FlowStep, 
	AUD.DisplayName, 
	@usr AS UserId,
	1 AS IsSubGroup,
	BIL.AudienceId AS AudienceGroup,
	MEM.BilletId AS BilletId,
	GRP.SendToMember,
	GRP.IsRestrictedGroup
FROM AUDIENCE_GROUP AS GRP 
	INNER JOIN AUDIENCE_BILLET AS BIL 
	ON GRP.AudienceId = BIL.AudienceId 
	INNER JOIN AUDIENCE_MEMBER AS MEM 
	ON BIL.BilletId = MEM.BilletId
	INNER JOIN AUDIENCE AS AUD
	ON BIL.AudienceId = AUD.AudienceId 
WHERE (GRP.GroupId = @grp) 
	AND (MEM.TechnicianId = @usr)
	AND (MEM.AudienceId = @aud)
