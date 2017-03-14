
create PROCEDURE [dbo].[procODS_PROVIDER_SelectbySSN]
(
	@ssn varchar(30)
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
	(ProviderSSN = @ssn)
