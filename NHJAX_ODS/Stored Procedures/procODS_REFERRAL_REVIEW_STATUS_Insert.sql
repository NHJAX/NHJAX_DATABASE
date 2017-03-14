
create PROCEDURE [dbo].[procODS_REFERRAL_REVIEW_STATUS_Insert]
(
	@ref bigint,
	@stat bigint,
	@dt datetime,
	@key numeric(8,3),
	@com varchar(4000),
	@pro bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.REFERRAL_REVIEW_STATUS
(
	ReferralId,
	ReviewStatusId, 
	ReferralReviewDate,
	ReferralReviewStatusKey,
	ReviewComment,
	ReviewerId
) 
VALUES
(
	@ref,
	@stat,
	@dt,
	@key,
	@com,
	@pro
);
SELECT SCOPE_IDENTITY();