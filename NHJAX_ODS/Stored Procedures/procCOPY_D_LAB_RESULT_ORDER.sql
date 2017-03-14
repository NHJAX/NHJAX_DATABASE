
CREATE PROCEDURE [dbo].[procCOPY_D_LAB_RESULT_ORDER]

AS
DECLARE @sdate datetime
DECLARE @edate datetime

SET @sdate = dbo.StartOfDay('2014-01-01')
SET @edate = dbo.EndOfDay(GETDATE())

TRUNCATE TABLE ODS_COPY.dbo.D_LAB_RESULT_ORDER

INSERT INTO ODS_COPY.dbo.D_LAB_RESULT_ORDER
(
PatientId,
FMP_SSN,
PatientIdentifier,
EREntryNumber,
OrderKey, 
OrderNumber, 
LabTest, 
OrderDateTime, 
EnterPerson, 
CollectionDateTime, 
CollectionSample, 
LoginDateTime, 
AccessionStatus, 
CertifyDateTime, 
CertifyPerson, 
Result,
DisplayText,
LocationPerformed,
LabTestType
)
SELECT
PAT.PatientId,
FMP.FamilyMemberPrefixCode + '/' +
PAT.SponsorSSN,
PAT.PatientIdentifier,
ENC.EREntryNumber,    
ORD.OrderKey, 
ORD.OrderNumber, 
LAB_TEST.LabTestDesc,
ORD.OrderDateTime,
EUSR.CHCSUserName,
RES.TakenDate,
SAMP.CollectionSampleDesc,
RES.LogInDate,
STAT.OrderStatusDesc,
RES.CertifyDate,
CUSR.CHCSUserName,
RES.Result,
DisplayText,
LOC.HospitalLocationName,
CASE LAB_TEST.LabTestTypeId
	WHEN 0 THEN 'SINGLE'
	ELSE 'PANEL'
END AS LabTestType
FROM PATIENT_ORDER AS ORD
INNER JOIN PATIENT AS PAT
ON ORD.PatientId = PAT.PatientId
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP
ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
LEFT OUTER JOIN PROVIDER AS RPRO
ON ORD.RequestingProviderId = RPRO.ProviderId
LEFT OUTER JOIN LAB_TEST 
INNER JOIN LAB_RESULT AS RES 
ON LAB_TEST.LabTestid = RES.LabTestId 
ON ORD.OrderId = RES.OrderId 
LEFT OUTER JOIN CHCS_USER AS EUSR
ON RES.EnterPersonId = EUSR.CHCSUserId
LEFT OUTER JOIN CHCS_USER AS CUSR
ON RES.CertifyPersonId = CUSR.CHCSUserId
LEFT OUTER JOIN COLLECTION_SAMPLE AS SAMP
ON ORD.CollectionSampleId = SAMP.CollectionSampleId
INNER JOIN ORDER_STATUS AS STAT
ON ORD.OrderStatusId = STAT.OrderStatusId
LEFT OUTER JOIN CHCS_USER AS RUSR
ON RES.RNRPersonId = RUSR.CHCSUserId
LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC
ON ORD.PatientEncounterId = ENC.PatientEncounterId
LEFT OUTER JOIN HOSPITAL_LOCATION AS LOC
ON RES.LabWorkElementId = LOC.HospitalLocationId
WHERE     (ORD.PatientEncounterId IN
  (SELECT     PatientEncounterId
    FROM          PATIENT_ENCOUNTER
    WHERE      (AppointmentDateTime > '2014-01-01')
    AND AppointmentDateTime < GETDATE()
     AND (HospitalLocationId = 174)))
AND OrderTypeId = 11