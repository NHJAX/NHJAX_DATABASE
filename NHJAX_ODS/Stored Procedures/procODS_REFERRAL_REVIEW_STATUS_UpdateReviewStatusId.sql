
CREATE PROCEDURE [dbo].[procODS_REFERRAL_REVIEW_STATUS_UpdateReviewStatusId]
(
	@id bigint,
	@stat bigint,
	@key decimal(8,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL_REVIEW_STATUS
SET ReviewStatusId = @stat,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)
AND ReferralReviewStatusKey = @key

