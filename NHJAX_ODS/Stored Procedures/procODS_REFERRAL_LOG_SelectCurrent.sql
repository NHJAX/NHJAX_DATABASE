﻿
CREATE PROCEDURE [dbo].[procODS_REFERRAL_LOG_SelectCurrent]
(
	@typ int = 0
)

AS
	SET NOCOUNT ON;
SELECT TOP 1 
	REFERRAL_LOG.ReferralLogId,   
	REFERRAL_LOG.ReferralLogDesc,
	REFERRAL_LOG.CreatedDate,
	REFERRAL_LOG.UserId,
	TECH.ULName,
	TECH.UFName,
	TECH.UMName
FROM REFERRAL_LOG
INNER JOIN vwENET_TECHNICIAN AS TECH
ON REFERRAL_LOG.UserId = TECH.UserId
WHERE LogTypeId = @typ
ORDER BY CreatedDate Desc
