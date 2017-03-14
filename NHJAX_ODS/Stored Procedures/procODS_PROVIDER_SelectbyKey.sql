
CREATE PROCEDURE [dbo].[procODS_PROVIDER_SelectbyKey]
(
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;
SELECT 	
	ProviderId,
	ProviderName, 
	ProviderClassId,
	LocationId,
	CreatedDate,
	UpdatedDate,
	SourceSystemId,
	DutyPhone,
	NPIKey,
	ProviderKey,
	ProviderSSN,
	ProviderCode
FROM
	PROVIDER 
WHERE 	
	(ProviderKey = @key)
