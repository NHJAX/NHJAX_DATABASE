
CREATE PROCEDURE [dbo].[procODS_ON_DEMAND_InsertPatientOrders] AS

DECLARE @maxord bigint
DECLARE @loop bigint
DECLARE @odcnt int

SELECT @odcnt = COUNT(OnDemandId) 
	FROM ON_DEMAND
	
IF(@odcnt = 0)
BEGIN
SELECT @maxord = MAX(OrderKey) FROM PATIENT_ORDER
WHERE OrderNumber IS NOT NULL
	AND SourceSystemId NOT IN (6,8)

SET @loop = @maxord - 2000
	
WHILE @loop <= @maxord + 1000
	BEGIN
		INSERT INTO ON_DEMAND
		(
			OnDemandTypeId,
			DemandKey
		)
		VALUES
		(
		7,
		CAST(@loop AS varchar(50))
		)
		SET @loop = @loop + 1
	END

END
