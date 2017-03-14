
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateReferralNumber]
(
	@id bigint,
	@num varchar(11)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET ReferralNumber = @num,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

