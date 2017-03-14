


CREATE PROCEDURE [dbo].[upEDPTS_Cost20120815]
(
@pro decimal, 
@date datetime,
@cost money output
)
AS  
BEGIN

DECLARE @start datetime
DECLARE @end datetime

SET @start = dbo.StartofDay(@date)
SET @end = dbo.EndofDay(@date)

	SELECT @cost =    
		ISNULL(SUM(PO.OrderCost),0)
		FROM PATIENT_ENCOUNTER PE
		INNER JOIN PATIENT_ORDER PO
		ON PE.PatientEncounterId = PO.PatientEncounterId 
		INNER JOIN PROVIDER PRO
		ON PE.ProviderId = PRO.ProviderId
		WHERE (PE.HospitalLocationId = 174) 
		AND (PE.AppointmentStatusId NOT IN (7, 10)) 
		AND (PE.AppointmentDateTime 
		BETWEEN @start 
		AND @end) 
		AND (PO.OrderTypeId IN (11, 15, 16)) 
		AND (PRO.ProviderKey = @pro)
END



