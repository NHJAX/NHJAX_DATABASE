
create PROCEDURE [dbo].[procODS_REFERRAL_REVIEW_STATUS_UpdateReviewerId]
(
	@id bigint,
	@pro bigint,
	@key decimal(8,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL_REVIEW_STATUS
SET ReviewerId = @pro,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)
AND ReferralReviewStatusKey = @key

