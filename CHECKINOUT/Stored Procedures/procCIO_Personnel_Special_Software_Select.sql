
CREATE PROCEDURE [dbo].[procCIO_Personnel_Special_Software_Select]
(
	@pers bigint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	AudienceId
FROM PERSONNEL_SPECIAL_SOFTWARE
WHERE PersonnelId = @pers

END

