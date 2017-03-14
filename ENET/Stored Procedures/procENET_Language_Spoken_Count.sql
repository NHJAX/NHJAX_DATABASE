
create PROCEDURE [dbo].[procENET_Language_Spoken_Count]
(
	@usr int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	Count(LanguageId)
FROM LANGUAGE_SPOKEN
WHERE UserId = @usr

END

