
create PROCEDURE [dbo].[procCIO_Language_Spoken_Count]
(
	@pers bigint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	Count(LanguageId)
FROM LANGUAGE_SPOKEN
WHERE PersonnelId = @pers

END

