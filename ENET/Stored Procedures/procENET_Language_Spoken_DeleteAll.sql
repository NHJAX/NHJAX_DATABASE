create PROCEDURE [dbo].[procENET_Language_Spoken_DeleteAll]
(
	@usr int
)
 AS

DELETE FROM LANGUAGE_SPOKEN
WHERE UserId = @usr;




