CREATE PROCEDURE [dbo].[procCIO_Language_Spoken_Delete]
(
	@pers bigint,
	@lang int,
	@sess varchar(50)
)
 AS

IF @pers = 0
BEGIN
DELETE FROM LANGUAGE_SPOKEN
WHERE SessionKey = @sess
AND LanguageId = @lang;
END
ELSE
BEGIN
DELETE FROM LANGUAGE_SPOKEN
WHERE PersonnelId = @pers
AND LanguageId = @lang;
END




