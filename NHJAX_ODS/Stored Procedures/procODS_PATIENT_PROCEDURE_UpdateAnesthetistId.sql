
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_UpdateAnesthetistId]
(
	@id bigint,
	@ane bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_PROCEDURE
SET SurgeonId = @ane,
UpdatedDate = GETDATE()
WHERE (ProcedureId = @id)


