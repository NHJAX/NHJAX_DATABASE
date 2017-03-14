
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateReferredToProviderId]
(
	@id bigint,
	@rtp bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET ReferredToProviderId = @rtp,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

