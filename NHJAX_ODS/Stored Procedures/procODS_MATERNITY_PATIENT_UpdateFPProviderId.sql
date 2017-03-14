
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_UpdateFPProviderId]
(
	@mpat bigint,
	@fpro int,
	@uby int
)
AS
	SET NOCOUNT ON;

BEGIN

UPDATE MATERNITY_PATIENT
SET FPProviderId = @fpro,
	UpdatedBy = @uby,
	UpdatedDate = GETDATE()
WHERE MaternityPatientId = @mpat
END


