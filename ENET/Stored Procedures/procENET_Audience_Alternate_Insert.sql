create PROCEDURE [dbo].[procENET_Audience_Alternate_Insert]
(
	@aud bigint,
	@usr int
)
 AS

INSERT INTO AUDIENCE_ALTERNATE
(
AudienceId,
TechnicianId
)
VALUES
(
@aud,
@usr
)

