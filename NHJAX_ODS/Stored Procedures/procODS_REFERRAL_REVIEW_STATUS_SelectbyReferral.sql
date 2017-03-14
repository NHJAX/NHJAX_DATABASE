
CREATE PROCEDURE [dbo].[procODS_REFERRAL_REVIEW_STATUS_SelectbyReferral] 
(
	@ref bigint,
	@ln decimal(8,3)
)
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT     
		ReferralReviewStatusId, 
		ReferralId,
		ReviewStatusId, 
		ReferralReviewDate, 
		ReferralReviewStatusKey,
		REPLACE(REPLACE(REPLACE(REPLACE(ReviewComment,'     ',' '),'    ',' '),'   ',' '),'  ',' ') AS ReviewComment, 
		CreatedDate,
		ReviewerId 
	FROM REFERRAL_REVIEW_STATUS 
	WHERE ReferralId = @ref
	AND ReferralReviewStatusKey = @ln;

END





