
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_UpdateCptId]
(
	@id bigint,
	@cpt bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_PROCEDURE
SET CptId = @cpt,
UpdatedDate = GETDATE()
WHERE (ProcedureId = @id)


