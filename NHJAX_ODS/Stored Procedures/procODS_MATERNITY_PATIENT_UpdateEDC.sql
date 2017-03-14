
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_UpdateEDC]
(
	@mpat bigint,
	@edc datetime,
	@uby int
)
AS
	SET NOCOUNT ON;

BEGIN

UPDATE MATERNITY_PATIENT
SET EDC = @edc,
	UpdatedBy = @uby,
	UpdatedDate = GETDATE()
WHERE MaternityPatientId = @mpat
END


