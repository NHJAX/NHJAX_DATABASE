CREATE PROCEDURE [dbo].[procENET_Audience_Member_SelectbyAppUser](
	@usr int,
	@grp int
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
	MEM.BilletId as BilletId,
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
	AND (MEM.BilletId > 0)
	
--UNION
--SELECT     
--	0 AS AudienceMemberId, 
--	AudienceId, 
--	1 AS FlowStep, 
--	'My Leave Requests' AS DisplayName, 
--	@usr AS UserId, 
--	0 AS IsSubGroup, 
--	0 AS AudienceGroup, 
--	0 AS BilletId
--FROM AUDIENCE_GROUP AS GRP
--WHERE (GroupId = @grp) AND (AudienceId = 291)

