
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_UpdateRVU]
(
	@id bigint,
	@rvu money
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_PROCEDURE
SET RVU = @rvu,
UpdatedDate = GETDATE()
WHERE (ProcedureId = @id)


