create PROCEDURE [dbo].[procENET_Audience_Alternate_DeleteAll]
(
	@usr int
)
 AS

DELETE
FROM AUDIENCE_ALTERNATE
WHERE TechnicianId = @usr


