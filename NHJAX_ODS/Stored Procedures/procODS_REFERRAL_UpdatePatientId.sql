
CREATE PROCEDURE [dbo].[procODS_REFERRAL_UpdatePatientId]
(
	@id bigint,
	@pat bigint
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET PatientId = @pat,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

