
create PROCEDURE [dbo].[procFLOW_AudienceCategory_Select]

AS
SELECT AudienceCategoryId,
	AudienceCategoryDesc
FROM AUDIENCE_CATEGORY
WHERE AudienceCategoryId > 0
ORDER BY AudienceCategoryId


