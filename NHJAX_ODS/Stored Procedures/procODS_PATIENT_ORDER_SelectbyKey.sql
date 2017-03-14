
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_SelectbyKey]
(
	@key numeric(14,3)
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
WHERE (OrderKey = @key)
