
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateReferredByLocationId]
(
	@id bigint,
	@rbl bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET ReferredBylocationId = @rbl,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

