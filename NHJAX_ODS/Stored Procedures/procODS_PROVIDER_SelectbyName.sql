
CREATE PROCEDURE [dbo].[procODS_PROVIDER_SelectbyName]
(
	@name varchar(30)
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
	(ProviderName = @name)
