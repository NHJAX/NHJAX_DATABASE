
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateReferredToLocationId]
(
	@id bigint,
	@rtl bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET ReferredToLocationId = @rtl,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

