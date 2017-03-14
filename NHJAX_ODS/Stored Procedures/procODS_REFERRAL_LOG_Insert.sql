CREATE PROCEDURE [dbo].[procODS_REFERRAL_LOG_Insert]
(
	@desc	varchar(1000),
	@cby	int,
	@typ	int = 0
)
AS

INSERT INTO REFERRAL_LOG
(
	ReferralLogDesc,
	UserId,
	LogTypeId
) 
VALUES
(
	@desc,
	@cby,
	@typ
);

