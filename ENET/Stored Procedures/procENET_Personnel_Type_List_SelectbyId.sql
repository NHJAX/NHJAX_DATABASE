
create PROCEDURE [dbo].[procENET_Personnel_Type_List_SelectbyId]
(
	@usr int,
	@ptyp int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	ISNULL(COUNT(PersonnelTypeId),0) AS CountType
FROM PERSONNEL_TYPE_LIST
WHERE UserId = @usr
AND PersonnelTypeId = @ptyp

END

