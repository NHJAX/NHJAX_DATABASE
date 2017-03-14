
CREATE PROCEDURE [dbo].[procODS_PHARMACY_SelectbyId]
(
	@phar bigint
)
AS
	SET NOCOUNT ON;
	
SELECT PharmacyId,
	PharmacyDesc
FROM NHJAX_ODS.dbo.PHARMACY
WHERE PharmacyId = @phar
