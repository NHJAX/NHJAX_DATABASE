CREATE PROCEDURE [dbo].[procENET_Language_Spoken_Delete]
(
	@usr int,
	@lang int
)
 AS

DELETE FROM LANGUAGE_SPOKEN
WHERE UserId = @usr
AND LanguageId = @lang;




