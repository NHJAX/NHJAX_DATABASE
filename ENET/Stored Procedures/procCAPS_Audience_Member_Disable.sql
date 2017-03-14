create PROCEDURE [dbo].[procCAPS_Audience_Member_Disable]
(
	@usr int
)
 AS

DELETE
FROM AUDIENCE_MEMBER
WHERE TechnicianId = @usr



