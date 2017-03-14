
create PROCEDURE [dbo].[procODS_PROVIDER_SPECIALTY_SelectReferrals]

AS
	SET NOCOUNT ON;
SELECT 	
	ProviderSpecialtyId,
	ProviderSpecialtyDesc,
	CreatedDate
FROM
	PROVIDER_SPECIALTY 
ORDER BY ProviderSpecialtyDesc

