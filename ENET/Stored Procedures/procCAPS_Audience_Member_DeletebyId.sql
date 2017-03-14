create PROCEDURE [dbo].[procCAPS_Audience_Member_DeletebyId]
(
	@am bigint
)
 AS

DELETE
FROM AUDIENCE_MEMBER
WHERE AudienceMemberId = @am


