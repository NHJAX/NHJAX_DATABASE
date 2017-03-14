
create PROCEDURE [dbo].[procODS_REFERRAL_REFUSAL_Insert]
(
	@ref bigint,
	@key numeric(7,3),
	@rea bigint,
	@dt datetime
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.REFERRAL_REFUSAL
(
	ReferralRefusalKey,
	ReferralId, 
	RefusalReasonId,
	RefusalDateTime
) 
VALUES
(
	@key,
	@ref,
	@rea,
	@dt
);
SELECT SCOPE_IDENTITY();