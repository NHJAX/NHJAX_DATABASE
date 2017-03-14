
CREATE PROCEDURE [dbo].[procODS_REFERRAL_Insert]
(
	@key numeric(17,3),
	@dt datetime,
	@rea varchar(5000),
	@pto bigint,
	@pby bigint,
	@locto bigint,
	@locby bigint,
	@ord bigint,
	@ap bigint,
	@src bigint,
	@pt bigint,
	@sp bigint = 211,
	@auth numeric(21,3) = 0
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.REFERRAL
(
	ReferralKey,
	ReferralDate, 
	ReasonForReferral,
	ReferredToProviderId,
	ReferredByProviderId,
	ReferredToLocationId,
	ReferredByLocationId,
	PatientOrderId,
	AncillaryProcedureId,
	SourceSystemId,
	PlaceofTreatmentId,
	SpecialtyId,
	AuthorizationNumber,
	ReferralNumber
) 
VALUES
(
	@key,
	@dt,
	@rea,
	@pto,
	@pby,
	@locto,
	@locby,
	@ord,
	@ap,
	@src,
	@pt,
	@sp,
	@auth,
	LEFT(CAST(@key AS varchar(15)), 11)
);
SELECT SCOPE_IDENTITY();