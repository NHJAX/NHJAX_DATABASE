
create PROCEDURE [dbo].[procENET_TECHNICIAN_TIMEKEEPER_TYPE_Insert]
(
	@usr int,
	@typ int,
	@aud bigint,
	@cby int
)
AS
INSERT INTO TECHNICIAN_TIMEKEEPER_TYPE
(
	UserId,
	TimekeeperTypeId,
	AudienceId,
	CreatedBy
)
VALUES
(
	@usr,
	@typ,
	@aud,
	@cby
)






