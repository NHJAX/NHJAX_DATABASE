
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_UpdateSurgeonId]
(
	@id bigint,
	@sur bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_PROCEDURE
SET SurgeonId = @sur,
UpdatedDate = GETDATE()
WHERE (ProcedureId = @id)


