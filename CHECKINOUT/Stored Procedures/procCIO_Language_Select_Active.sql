
CREATE PROCEDURE [dbo].[procCIO_Language_Select_Active]
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
		LanguageId,
		LanguageDesc,
		Inactive
	FROM dbo.vwENET_LANGUAGE
	WHERE Inactive = 0
		AND LanguageId > 0
		AND LanguageId NOT IN
		(
			SELECT LanguageId
			FROM LANGUAGE_SPOKEN
			WHERE SessionKey = @sess
		)
	ORDER BY LanguageDesc
	END
	ELSE
	BEGIN
	SELECT 
		LanguageId,
		LanguageDesc,
		Inactive
	FROM dbo.vwENET_LANGUAGE
	WHERE Inactive = 0
		AND LanguageId > 0
		AND LanguageId NOT IN
		(
			SELECT LanguageId
			FROM LANGUAGE_SPOKEN
			WHERE PersonnelId = @pers
		)
	ORDER BY LanguageDesc
	END

END
