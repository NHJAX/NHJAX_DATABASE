
create PROCEDURE [dbo].[procODS_PROVIDER_SelectReferredTo]
(
	@all bit = 0
)
AS
	SET NOCOUNT ON;
	
IF @all = 0
BEGIN
SELECT 	DISTINCT
	PRO.ProviderId,
	PRO.ProviderName, 
	PRO.ProviderClassId,
	PRO.LocationId,
	PRO.CreatedDate,
	PRO.UpdatedDate,
	PRO.SourceSystemId,
	PRO.DutyPhone,
	PRO.NPIKey,
	PRO.ProviderKey,
	PRO.ProviderSSN,
	PRO.ProviderCode
FROM
	PROVIDER AS PRO 
	INNER JOIN REFERRAL AS REF
	ON PRO.ProviderId = REF.ReferredToProviderId
	INNER JOIN REFERRAL_MANAGEMENT.dbo.MAX_REFERRAL_HISTORY AS MAXR
	ON MAXR.ReferralId = REF.ReferralId
	INNER JOIN REFERRAL_MANAGEMENT.dbo.RM_HISTORY_TYPE AS HIST
	ON HIST.HistoryTypeId = MAXR.HistoryTypeId
WHERE 	
	HIST.IsClosed = 0
ORDER BY PRO.ProviderName
END
ELSE
BEGIN
	SELECT 	DISTINCT
	PRO.ProviderId,
	PRO.ProviderName, 
	PRO.ProviderClassId,
	PRO.LocationId,
	PRO.CreatedDate,
	PRO.UpdatedDate,
	PRO.SourceSystemId,
	PRO.DutyPhone,
	PRO.NPIKey,
	PRO.ProviderKey,
	PRO.ProviderSSN,
	PRO.ProviderCode
FROM
	PROVIDER AS PRO 
	INNER JOIN REFERRAL AS REF
	ON PRO.ProviderId = REF.ReferredToProviderId
	INNER JOIN REFERRAL_MANAGEMENT.dbo.MAX_REFERRAL_HISTORY AS MAXR
	ON MAXR.ReferralId = REF.ReferralId
	INNER JOIN REFERRAL_MANAGEMENT.dbo.RM_HISTORY_TYPE AS HIST
	ON HIST.HistoryTypeId = MAXR.HistoryTypeId
ORDER BY PRO.ProviderName
END
