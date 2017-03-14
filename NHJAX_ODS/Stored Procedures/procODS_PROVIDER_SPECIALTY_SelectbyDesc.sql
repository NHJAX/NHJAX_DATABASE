
create PROCEDURE [dbo].[procODS_PROVIDER_SPECIALTY_SelectbyDesc]
(
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT 	
	ProviderSpecialtyId,
	ProviderSpecialtyDesc,
	CreatedDate
FROM
	PROVIDER_SPECIALTY 
WHERE 	
	(ProviderSpecialtyDesc = @desc)
