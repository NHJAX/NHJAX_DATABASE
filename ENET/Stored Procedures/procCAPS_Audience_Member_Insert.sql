CREATE PROCEDURE [dbo].[procCAPS_Audience_Member_Insert]
(
	@aud bigint,
	@usr int,
	@bil int
)
 AS


INSERT INTO AUDIENCE_MEMBER
(
BilletId,
AudienceId,
TechnicianId
)
VALUES
(
@bil,
@aud,
@usr
)

