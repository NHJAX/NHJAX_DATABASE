
create PROCEDURE [dbo].[procODS_REFERRAL_Update]
(
	@id bigint,
	@sp bigint,
	@auth numeric(21,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET SpecialtyId = @sp,
AuthorizationNumber = @auth
WHERE (ReferralId = @id)

