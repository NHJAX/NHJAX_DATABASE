
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_UpdateMaternityStatusId]
(
	@mpat bigint,
	@stat int,
	@uby int
)
AS
	SET NOCOUNT ON;

BEGIN

UPDATE MATERNITY_PATIENT
SET MaternityStatusId = @stat,
	UpdatedBy = @uby,
	UpdatedDate = GETDATE()
WHERE MaternityPatientId = @mpat
END


