
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_UpdateProcedureTypeId]
(
	@id bigint,
	@ptyp bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_PROCEDURE
SET ProcedureTypeId = @ptyp,
UpdatedDate = GETDATE()
WHERE (ProcedureId = @id)


