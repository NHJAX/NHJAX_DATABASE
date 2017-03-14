CREATE PROCEDURE [dbo].[procENET_Audience_Group_SelectbyCustomGroup]
(
	@grp int,
	@cat int
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
FROM	AUDIENCE_GROUP GRP
INNER JOIN AUDIENCE AUD
ON AUD.AudienceId = GRP.AudienceId
WHERE	(GRP.GroupId = @grp)
	AND GRP.AudienceCategoryId = @cat
