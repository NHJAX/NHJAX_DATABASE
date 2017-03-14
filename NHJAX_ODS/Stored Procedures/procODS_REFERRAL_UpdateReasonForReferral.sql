
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateReasonForReferral]
(
	@id bigint,
	@rea varchar(5000)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET ReasonForReferral = @rea,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

