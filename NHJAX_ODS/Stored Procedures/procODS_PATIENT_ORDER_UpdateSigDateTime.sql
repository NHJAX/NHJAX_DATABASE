
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateSigDateTime]
(
	@id bigint,
	@sig datetime
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET SigDateTime = @sig,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


