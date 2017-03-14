
create PROCEDURE [dbo].[procENET_Education_Level_Select]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	EducationLevelId,
	EducationLevelDesc
FROM EDUCATION_LEVEL
ORDER BY EducationLevelId
END

