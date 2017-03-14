
create PROCEDURE [dbo].[procENET_Personnel_Type_Select]
(
	@typ int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	PersonnelTypeId,
	PersonnelTypeDesc,
	Inactive
FROM PERSONNEL_TYPE
WHERE PersonnelTypeId = @typ
END

