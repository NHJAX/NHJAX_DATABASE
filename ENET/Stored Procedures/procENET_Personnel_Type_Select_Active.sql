
CREATE PROCEDURE [dbo].[procENET_Personnel_Type_Select_Active]

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
WHERE Inactive = 0
	AND PersonnelTypeId > 0
ORDER BY PersonnelTypeDesc
END

