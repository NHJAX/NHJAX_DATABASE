
CREATE PROCEDURE [dbo].[procODS_PRESCRIPTION_Select]
(
	@rx varchar(20),
	@pat bigint,
	@phar bigint
)
AS
	SET NOCOUNT ON;
	
Select 	PrescriptionId,
		RXNumber,
		PatientId,
		PreStatusId,
		AcceptedPrescriber,
		SourceSystemId,
		PharmacyId,
		DrugId
FROM NHJAX_ODS.dbo.PRESCRIPTION
WHERE RXNumber = @rx
	AND PatientId = @pat
	AND PharmacyId = @phar
