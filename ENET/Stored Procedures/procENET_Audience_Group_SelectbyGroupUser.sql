CREATE PROCEDURE [dbo].[procENET_Audience_Group_SelectbyGroupUser]
(
	@grp int,
	@usr int,
	@aud bigint
)
 AS

SELECT     
	GRP.AudienceCategoryId, 
	GRP.AudienceId, 
	GRP.GroupId, 
	GRP.CreatedDate, 
	GRP.FlowStep, 
	GRP.EMailNotification, 
	AUD.DisplayName, 
	AUD.IsSpecialSoftware, 
	GRP.SendToMember,
	GRP.CheckOutNotification,
	GRP.SecurityNotification,
	GRP.IsLeaveAlternate,
	GRP.IsLeaveEdit
FROM	AUDIENCE_GROUP AS GRP 
	INNER JOIN AUDIENCE AS AUD 
	ON GRP.AudienceId = AUD.AudienceId
WHERE (GRP.GroupId = @grp) 
	AND (AUD.AudienceCategoryId NOT IN (1,4))
	AND (AUD.AudienceId NOT IN (11))
	AND (AUD.DisplayName NOT LIKE '%Initiator')
	AND (AUD.AudienceId NOT IN
		(SELECT     
			AudienceId
		FROM	AUDIENCE_MEMBER
		WHERE	(TechnicianId = @usr)
			UNION
		SELECT     
			AB.AudienceId
		FROM	AUDIENCE_BILLET AS AB
			INNER JOIN AUDIENCE_MEMBER AS MEM 
			ON AB.BilletId = MEM.BilletId
		WHERE	(MEM.TechnicianId = @usr)
		AND (MEM.AudienceId = @aud)))

