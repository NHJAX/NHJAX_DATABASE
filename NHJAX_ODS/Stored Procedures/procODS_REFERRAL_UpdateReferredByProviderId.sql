
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateReferredByProviderId]
(
	@id bigint,
	@rbp bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET ReferredByProviderId = @rbp,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

