
CREATE PROCEDURE [dbo].[procENET_Language_Spoken_Select]
(
	@usr int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	LS.LanguageId,
	LANG.LanguageDesc
FROM LANGUAGE_SPOKEN AS LS
	INNER JOIN [LANGUAGE] AS LANG
	ON LANG.LanguageId = LS.LanguageId
WHERE UserId = @usr

END

