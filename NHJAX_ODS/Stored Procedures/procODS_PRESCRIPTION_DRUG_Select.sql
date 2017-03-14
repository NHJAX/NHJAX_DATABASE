
CREATE PROCEDURE [dbo].[procODS_PRESCRIPTION_DRUG_Select]
(
	@drug bigint,
	@pre bigint
)
AS
	SET NOCOUNT ON;
	
SELECT 	PrescriptionDrugId
FROM NHJAX_ODS.dbo.PRESCRIPTION_DRUG
WHERE PrescriptionId = @pre
	AND DrugId = @drug
