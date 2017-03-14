
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateSpecialtyId]
(
	@id bigint,
	@spec bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET SpecialtyId = @spec,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

