
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateOrderId]
(
	@id bigint,
	@ord bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET PatientOrderId = @ord,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

