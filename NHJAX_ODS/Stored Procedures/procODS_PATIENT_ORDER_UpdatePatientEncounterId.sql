
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdatePatientEncounterId]
(
	@id bigint,
	@pe bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET PatientEncounterId = @pe,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


