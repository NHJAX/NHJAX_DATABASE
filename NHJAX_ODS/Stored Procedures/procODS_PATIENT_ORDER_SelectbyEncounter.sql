
CREATE PROCEDURE [dbo].[procODS_PATIENT_ORDER_SelectbyEncounter]
(
	@enc bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	OrderId,
	OrderTypeId,
	SigDateTime,
	OrderDateTime,
	OrderComment,
	OrderingProviderId,
	OrderPriorityId,
	AncillaryProcedureId,
	LocationId,
	OrderStatusId,
	PatientId
FROM PATIENT_ORDER
WHERE (PatientEncounterId = @enc)
