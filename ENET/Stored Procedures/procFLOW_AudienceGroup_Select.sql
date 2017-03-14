
CREATE PROCEDURE [dbo].[procFLOW_AudienceGroup_Select]
(
	@grp int
)
AS
SELECT AudienceCategoryId,
	AudienceId,
	GroupId,
	FlowStep
FROM AUDIENCE_GROUP
WHERE GroupId = @grp
ORDER BY FlowStep


