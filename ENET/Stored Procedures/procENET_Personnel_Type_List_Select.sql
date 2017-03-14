
CREATE PROCEDURE [dbo].[procENET_Personnel_Type_List_Select]
(
	@usr int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	PersonnelTypeId
FROM PERSONNEL_TYPE_LIST
WHERE UserId = @usr

END

