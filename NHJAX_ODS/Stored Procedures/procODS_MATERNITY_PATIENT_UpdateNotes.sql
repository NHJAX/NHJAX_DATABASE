
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_UpdateNotes]
(
	@mpat bigint,
	@com varchar(8000),
	@uby int
)
AS
	SET NOCOUNT ON;

BEGIN

UPDATE MATERNITY_PATIENT
SET Notes = @com,
	UpdatedBy = @uby,
	UpdatedDate = GETDATE()
WHERE MaternityPatientId = @mpat
END


