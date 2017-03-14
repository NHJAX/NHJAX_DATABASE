
create PROCEDURE [dbo].[procODS_PRESCRIPTION_Update]
(
	@drug bigint,
	@rx varchar(20),
	@pat bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE NHJAX_ODS.dbo.PRESCRIPTION				
SET DrugId = @drug
WHERE RXNumber = @rx
AND PatientId = @pat

