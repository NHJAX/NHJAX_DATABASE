
CREATE PROCEDURE [dbo].[upODS_DM_CIP_Order] AS

Declare @fromDate datetime
Declare @tempDate datetime
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin DM CIP Orders',0,@day;
SET @tempDate = DATEADD(d,-180,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

BEGIN
DELETE FROM CIP.dbo.DM_CIP_ORDER
WHERE OrderDateTime >= @fromDate

INSERT INTO CIP.dbo.DM_CIP_ORDER
(
	HospitalLocationId, 
	OrderCost, 
	OrderDateTime, 
	DmisId, 
	MeprsCodeId,
	OrderId,
	ProviderId,
	OrderTypeId
)
SELECT 	
	LOC.HospitalLocationId, 
	ORD.OrderCost,
	ORD.OrderDateTime,
	MPR.DmisId,
	MPR.MeprsCodeId,
	ORD.OrderId,
	PRO.ProviderId,
	ORD.OrderTypeId
FROM 		
	HOSPITAL_LOCATION LOC 
	INNER JOIN 
	PATIENT_ORDER ORD 
	ON ORD.LocationId = LOC.HospitalLocationId
	INNER JOIN PROVIDER PRO 
	ON PRO.ProviderId = ORD.OrderingProviderId
	INNER JOIN MEPRS_CODE MPR 
	ON MPR.MeprsCodeId = LOC.MeprsCodeId

WHERE	ORD.OrderTypeId IN (5,11,15,16)
		AND PRO.PROVIDERFLAG = 1
		AND LOC.HospitalLocationName NOT LIKE 'QQQ%'
		AND ORD.OrderDateTime >= @fromDate
END


EXEC dbo.upActivityLog 'End DM CIP Orders',0,@day;












