
create PROCEDURE [dbo].[procODS_PRESCRIPTION_DRUG_Insert]
(
	@drug bigint,
	@pre bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_DRUG
(
	PrescriptionId,
	DrugId)
VALUES(@pre,@drug);
SELECT SCOPE_IDENTITY();
