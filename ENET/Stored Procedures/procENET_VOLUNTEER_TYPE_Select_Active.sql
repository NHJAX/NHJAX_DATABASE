
create PROCEDURE [dbo].[procENET_VOLUNTEER_TYPE_Select_Active]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	VolunteerTypeId,
	VolunteerTypeDesc,
	Inactive
FROM VOLUNTEER_TYPE
WHERE Inactive = 0
	AND VolunteerTypeId > 0
ORDER BY VolunteerTypeDesc
END

