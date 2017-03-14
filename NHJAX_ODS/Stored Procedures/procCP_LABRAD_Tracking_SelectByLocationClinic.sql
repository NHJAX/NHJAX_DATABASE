-- =============================================
-- Author:		Robert Evans
-- Create date: 4 Dec 2014
-- Description:	Gets The LAB RAD Tracker List By Clinic
-- =============================================
CREATE PROCEDURE [dbo].[procCP_LABRAD_Tracking_SelectByLocationClinic]
@providerid int = 0, @clinicid int = 0, @locationid int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 'LAB' as 'LABRAD',
P.FullName,
COUNT(PO.OrderId) as 'NumberofLabs', 
PO.PatientId, 
HL.HospitalLocationName,
PR.LocationId,
PR.ProviderName,
MIN(PO.OrderDateTime) as 'OldestOrder',
DATEDIFF(d,MIN(PO.OrderDateTime),GETDATE()) as 'DaysOld'
,dbo.AudiocareResults(PO.PatientId,'LAB') as AudioCareResults
FROM PATIENT_ORDER AS PO
INNER JOIN PATIENT AS P ON PO.PatientId = P.PatientId
INNER JOIN ORDER_TYPE AS OT ON OT.OrderTypeId = PO.OrderTypeId
INNER JOIN ORDER_STATUS AS OS ON OS.OrderStatusId = PO.OrderStatusId
INNER JOIN HOSPITAL_LOCATION AS HL ON HL.HospitalLocationId = PO.LocationId AND HL.HospitalLocationId IN (2674,2675,2678,419,206,2679,356,340,278,2824,2825,36)
INNER JOIN PROVIDER AS PR ON PR.ProviderId = PO.OrderingProviderId
INNER JOIN [NHJAX_ODS].dbo.MEPRS_CODE as MC ON MC.MeprsCodeId = HL.MeprsCodeId
WHERE PO.OrderTypeId = 11 --  LAB Order Type = 11, RAD Order Type = 15
AND PO.OrderStatusId = 24 -- Order Status 24 = UNACKNOWLEDGED
AND PO.OrderDateTime > DATEADD(day,-45,GETDATE())
AND PO.OrderDateTime < DATEADD(day,-7,GETDATE())
AND ISNULL(PR.ProviderId,0) = CASE WHEN @providerid = 0 THEN ISNULL(PR.ProviderId,0) ELSE @providerid END
AND ISNULL(PR.LocationId,0) = CASE WHEN @clinicid = 0 THEN ISNULL(PR.LocationId,0) ELSE @clinicid END
AND ISNULL(MC.DmisId,0) = CASE WHEN @locationid = 0 THEN ISNULL(MC.DmisId,0) ELSE @locationid END
GROUP BY PO.PatientId, P.FullName, HL.HospitalLocationName, PR.LocationId, PR.ProviderName
UNION
SELECT 'RAD',
P.FullName,
COUNT(PO.OrderId) as 'NumberofRabs', 
PO.PatientId, 
HL.HospitalLocationName,
PR.LocationId,
PR.ProviderName,
MIN(PO.OrderDateTime) as 'OldestOrder',
DATEDIFF(d,MIN(PO.OrderDateTime),GETDATE()) as 'DaysOld'
,dbo.AudiocareResults(PO.PatientId,'LAB') as AudioCareResults
FROM PATIENT_ORDER AS PO
INNER JOIN PATIENT AS P ON PO.PatientId = P.PatientId
INNER JOIN ORDER_TYPE AS OT ON OT.OrderTypeId = PO.OrderTypeId
INNER JOIN ORDER_STATUS AS OS ON OS.OrderStatusId = PO.OrderStatusId
INNER JOIN HOSPITAL_LOCATION AS HL ON HL.HospitalLocationId = PO.LocationId AND HL.HospitalLocationId IN (2674,2675,2678,419,206,2679,356,340,278,2824,2825,36)
INNER JOIN PROVIDER AS PR ON PR.ProviderId = PO.OrderingProviderId
INNER JOIN [NHJAX_ODS].dbo.MEPRS_CODE as MC ON MC.MeprsCodeId = HL.MeprsCodeId
WHERE PO.OrderTypeId = 15 --  LAB Order Type = 11, RAD Order Type = 15
AND PO.OrderStatusId = 7 -- Order Status 7 = ACKNOWLEDGED
AND PO.OrderDateTime > DATEADD(day,-45,GETDATE())
AND PO.OrderDateTime < DATEADD(day,-7,GETDATE())
AND ISNULL(PR.ProviderId,0) = CASE WHEN @providerid = 0 THEN ISNULL(PR.ProviderId,0) ELSE @providerid END
AND ISNULL(PR.LocationId,0) = CASE WHEN @clinicid = 0 THEN ISNULL(PR.LocationId,0) ELSE @clinicid END
AND ISNULL(MC.DmisId,0) = CASE WHEN @locationid = 0 THEN ISNULL(MC.DmisId,0) ELSE @locationid END
GROUP BY PO.PatientId, P.FullName, HL.HospitalLocationName, PR.LocationId, PR.ProviderName
ORDER BY PO.PatientId

END
