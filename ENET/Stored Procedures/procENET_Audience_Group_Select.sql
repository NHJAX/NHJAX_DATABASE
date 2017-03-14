CREATE PROCEDURE [dbo].[procENET_Audience_Group_Select]
(
	@grp int,
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
	CAST(0 AS bit) AS IsSpecialSoftware, 
	GRP.SendToMember,
	GRP.CheckOutNotification,
	GRP.SecurityNotification,
	GRP.IsLeaveAlternate,
	GRP.IsLeaveEdit
FROM AUDIENCE_GROUP AS GRP 
	INNER JOIN AUDIENCE AS AUD 
	ON GRP.AudienceId = AUD.AudienceId
WHERE     (GRP.GroupId = @grp) AND (GRP.AudienceId = @aud)
