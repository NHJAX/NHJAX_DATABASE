
create PROCEDURE [dbo].[procODS_PROVIDER_SelectbyDoDEDI]
(
	@dod varchar(50)
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
	(DodEDI = @dod)
