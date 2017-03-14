
CREATE PROCEDURE [dbo].[procODS_PROVIDER_SelectbyNPI]
(
	@npi numeric(16,3)
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
	(NPIKey = CAST(@npi AS varchar(20)))
