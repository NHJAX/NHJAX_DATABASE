
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateAncillaryProcedureId]
(
	@id bigint,
	@anc bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET AncillaryProcedureId = @anc,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


