-- =============================================
-- Author:		Robert Evans
-- Create date: 10/7/2014
-- Description:	Populates the Data Warehouse with LABRAD Data Daily.
-- =============================================
CREATE PROCEDURE procDW_GETDAILYLABRAD 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [NHJAX_ODS_DW].dbo.[DW_LABRAD]
           ([LABRADTYPE]
           ,[LABRADCOUNT]
           ,[PATIENTID]
           ,[HOSPITALLOCATIONID]
           ,[PROVIDERID]
           ,[OLDESTORDERDATE]
           ,[DAYSOLD]
           ,[AUDIOCARERESULTS])
SELECT 1,
COUNT(PO.OrderId), 
PO.PatientId, 
HL.HospitalLocationId,
PR.ProviderId,
MIN(PO.OrderDateTime),
DATEDIFF(d,MIN(PO.OrderDateTime),GETDATE()),
dbo.AudiocareResults(PO.PatientId,'LAB')
FROM PATIENT_ORDER AS PO
INNER JOIN PATIENT AS P ON PO.PatientId = P.PatientId
INNER JOIN ORDER_TYPE AS OT ON OT.OrderTypeId = PO.OrderTypeId
INNER JOIN ORDER_STATUS AS OS ON OS.OrderStatusId = PO.OrderStatusId
INNER JOIN HOSPITAL_LOCATION AS HL ON HL.HospitalLocationId = PO.LocationId AND HL.HospitalLocationId IN (2674,2675,2678,419,206,2679,356,340,278,2824,2825,36)
INNER JOIN PROVIDER AS PR ON PR.ProviderId = PO.OrderingProviderId
WHERE PO.OrderTypeId = 11 --  LAB Order Type = 11, RAD Order Type = 15
AND PO.OrderStatusId = 24 -- Order Status 24 = UNACKNOWLEDGED
AND PO.OrderDateTime > DATEADD(day,-45,GETDATE())
AND PO.OrderDateTime < DATEADD(day,-7,GETDATE())
GROUP BY PO.PatientId, P.FullName, HL.HospitalLocationId, PR.ProviderId

INSERT INTO [NHJAX_ODS_DW].dbo.[DW_LABRAD]
           ([LABRADTYPE]
           ,[LABRADCOUNT]
           ,[PATIENTID]
           ,[HOSPITALLOCATIONID]
           ,[PROVIDERID]
           ,[OLDESTORDERDATE]
           ,[DAYSOLD]
           ,[AUDIOCARERESULTS])
SELECT 2,
COUNT(PO.OrderId), 
PO.PatientId, 
HL.HospitalLocationId,
PR.ProviderId,
MIN(PO.OrderDateTime),
DATEDIFF(d,MIN(PO.OrderDateTime),GETDATE()),
dbo.AudiocareResults(PO.PatientId,'LAB')
FROM PATIENT_ORDER AS PO
INNER JOIN PATIENT AS P ON PO.PatientId = P.PatientId
INNER JOIN ORDER_TYPE AS OT ON OT.OrderTypeId = PO.OrderTypeId
INNER JOIN ORDER_STATUS AS OS ON OS.OrderStatusId = PO.OrderStatusId
INNER JOIN HOSPITAL_LOCATION AS HL ON HL.HospitalLocationId = PO.LocationId AND HL.HospitalLocationId IN (2674,2675,2678,419,206,2679,356,340,278,2824,2825,36)
INNER JOIN PROVIDER AS PR ON PR.ProviderId = PO.OrderingProviderId
WHERE PO.OrderTypeId = 15 --  LAB Order Type = 11, RAD Order Type = 15
AND PO.OrderStatusId = 7 -- Order Status 7 = ACKNOWLEDGED
AND PO.OrderDateTime > DATEADD(day,-45,GETDATE())
AND PO.OrderDateTime < DATEADD(day,-7,GETDATE())
GROUP BY PO.PatientId, P.FullName, HL.HospitalLocationId, PR.ProviderId


END
