
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateAuthorizationNumber]
(
	@id bigint,
	@auth decimal(21,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET AuthorizationNumber = @auth,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

