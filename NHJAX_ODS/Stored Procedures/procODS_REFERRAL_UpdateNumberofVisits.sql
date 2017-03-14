
create PROCEDURE [dbo].[procODS_REFERRAL_UpdateNumberofVisits]
(
	@id bigint,
	@num decimal(8,3)
)
AS
	SET NOCOUNT ON;
UPDATE REFERRAL
SET NumberofVisits = @num,
UpdatedDate = GETDATE()
WHERE (ReferralId = @id)

