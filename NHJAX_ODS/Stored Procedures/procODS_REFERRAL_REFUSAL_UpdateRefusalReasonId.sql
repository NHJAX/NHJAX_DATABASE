
CREATE PROCEDURE [dbo].[procODS_REFERRAL_REFUSAL_UpdateRefusalReasonId]
(
	@id bigint,
	@rea bigint,
	@ln decimal(7,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL_REFUSAL
SET RefusalReasonId = @rea,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)
AND ReferralRefusalKey = @ln

