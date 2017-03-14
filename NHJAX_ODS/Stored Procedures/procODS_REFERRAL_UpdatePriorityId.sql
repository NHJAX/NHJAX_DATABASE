
create PROCEDURE [dbo].[procODS_REFERRAL_UpdatePriorityId]
(
	@id bigint,
	@pri bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET PriorityId = @pri,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

