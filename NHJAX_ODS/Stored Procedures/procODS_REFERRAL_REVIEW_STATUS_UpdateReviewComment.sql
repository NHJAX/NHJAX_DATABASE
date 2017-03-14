
CREATE PROCEDURE [dbo].[procODS_REFERRAL_REVIEW_STATUS_UpdateReviewComment]
(
	@id bigint,
	@com varchar(4000),
	@key decimal(8,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL_REVIEW_STATUS
SET ReviewComment = @com,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)
AND ReferralReviewStatusKey = @key

