create PROCEDURE [dbo].[procENET_Audience_Alternate_Delete]
(
	@aa bigint
)
 AS

DELETE
FROM AUDIENCE_ALTERNATE
WHERE AudienceAlternateId = @aa


