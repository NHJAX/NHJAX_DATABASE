
create PROCEDURE [dbo].[procODS_ON_DEMAND_InsertBlankStatus] AS

INSERT INTO ON_DEMAND (DemandKey, OnDemandTypeId)
SELECT OrderKey, 7 FROM PATIENT_ORDER
WHERE OrderTypeId = 11
AND OrderStatusId = 47
AND OrderDateTime > DATEADD(day, -380, getdate())
