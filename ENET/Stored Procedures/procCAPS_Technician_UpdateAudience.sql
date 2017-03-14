create PROCEDURE [dbo].[procCAPS_Technician_UpdateAudience]
(
	@usr int,
	@uby int,
	@udate datetime,
	@aud bigint
)
AS
UPDATE TECHNICIAN SET
	AudienceId = @aud,
	UpdatedBy = @uby,
	UpdatedDate = @udate
WHERE UserId = @usr;


