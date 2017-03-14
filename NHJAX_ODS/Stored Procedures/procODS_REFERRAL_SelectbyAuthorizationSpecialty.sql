
CREATE PROCEDURE [dbo].[procODS_REFERRAL_SelectbyAuthorizationSpecialty]
(
	@auth numeric(17,3),
	@ap bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	ReferralId,
	AuthorizationNumber,
	SpecialtyId
FROM REFERRAL
WHERE (ReferralKey = @auth)
	AND (AncillaryProcedureId = @ap)
