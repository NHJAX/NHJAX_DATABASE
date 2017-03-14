
CREATE PROCEDURE [dbo].[procODS_REFERRAL_REFUSAL_SelectbyReferral] 
(
	@ref bigint,
	@ln decimal(7,3)
)
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT     
		ReferralRefusalId, 
		ReferralRefusalKey, 
		ReferralId, 
		RefusalStatusId, 
		RefusalReasonId, 
		RefusalDateTime, 
		CreatedDate, 
		UpdatedDate
	FROM REFERRAL_REFUSAL 
	WHERE ReferralId = @ref
	AND ReferralRefusalKey = @ln;

END





