
CREATE PROCEDURE [dbo].[procCIO_Language_Spoken_Select]
(
	@pers bigint,
	@sess varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF @pers = 0
BEGIN
SELECT 
	LS.LanguageId,
	LANG.LanguageDesc
FROM LANGUAGE_SPOKEN AS LS
	INNER JOIN dbo.vwENET_LANGUAGE AS LANG
	ON LANG.LanguageId = LS.LanguageId
WHERE SessionKey = @sess
END
ELSE
BEGIN
SELECT 
	LS.LanguageId,
	LANG.LanguageDesc
FROM LANGUAGE_SPOKEN AS LS
	INNER JOIN dbo.vwENET_LANGUAGE AS LANG
	ON LANG.LanguageId = LS.LanguageId
WHERE PersonnelId = @pers
END

END

