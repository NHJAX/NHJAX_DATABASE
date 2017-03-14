CREATE PROCEDURE [dbo].[procCAPS_Audience_Member_Delete]
(
	@am bigint,
	@usr int,
	@grp bigint
)
 AS

DELETE
FROM AUDIENCE_MEMBER
WHERE (TechnicianId = @usr
AND BilletId IN 
	(
	SELECT BilletId
	FROM AUDIENCE_BILLET
	WHERE (AudienceId = @grp)
	))
OR AudienceMemberId = @am


