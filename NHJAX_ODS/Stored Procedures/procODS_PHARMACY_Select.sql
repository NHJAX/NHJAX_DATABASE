
CREATE PROCEDURE [dbo].[procODS_PHARMACY_Select]
(
	@phar varchar(50)
)
AS
	SET NOCOUNT ON;
	
SELECT PharmacyId, 
	PharmacyDesc
FROM NHJAX_ODS.dbo.PHARMACY
WHERE PharmacyDesc = @phar
