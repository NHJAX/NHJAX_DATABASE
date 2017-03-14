
create PROCEDURE [dbo].[procENET_Language_Select]
(
	@lang int
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
WHERE LanguageId = @lang
END

