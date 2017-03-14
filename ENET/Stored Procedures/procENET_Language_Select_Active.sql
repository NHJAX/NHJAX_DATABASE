
CREATE PROCEDURE [dbo].[procENET_Language_Select_Active]
(
	@usr int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	LanguageId,
	LanguageDesc,
	Inactive
FROM [LANGUAGE]
WHERE Inactive = 0
	AND LanguageId > 0
	AND LanguageId NOT IN
	(
		SELECT LanguageId
		FROM LANGUAGE_SPOKEN
		WHERE UserId = @usr
	)
ORDER BY LanguageDesc
END

