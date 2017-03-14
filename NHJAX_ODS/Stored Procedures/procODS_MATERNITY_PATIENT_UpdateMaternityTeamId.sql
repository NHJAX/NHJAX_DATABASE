
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_UpdateMaternityTeamId]
(
	@mpat bigint,
	@tm int,
	@uby int
)
AS
	SET NOCOUNT ON;

BEGIN

UPDATE MATERNITY_PATIENT
SET MaternityTeamId = @tm,
	UpdatedBy = @uby,
	UpdatedDate = GETDATE()
WHERE MaternityPatientId = @mpat
END


