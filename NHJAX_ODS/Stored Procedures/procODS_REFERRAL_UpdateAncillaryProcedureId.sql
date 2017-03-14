
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateAncillaryProcedureId]
(
	@id bigint,
	@anc bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET AncillaryProcedureId = @anc,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

