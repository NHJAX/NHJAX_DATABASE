
CREATE PROCEDURE [dbo].[procCOPY_C_RADIOLOGY_EXAM_ORDERS]

AS

TRUNCATE TABLE ODS_COPY.dbo.C_RADIOLOGY_EXAM_ORDERS

DECLARE @sdate datetime
DECLARE @edate datetime

SET @sdate = dbo.StartOfDay('2014-01-01')
SET @edate = dbo.EndOfDay(GETDATE())

INSERT INTO ODS_COPY.dbo.C_RADIOLOGY_EXAM_ORDERS(
PatientId,
FMP_SSN,
PatientIdentifier,
EREntryNumber,
OrderKey, 
OrderNumber, 
OrderType,
OrderingProvider, 
OrderDateTime, 
ArrivalDateTime, 
ExamDateTime, 
DepartureDateTime, 
StartDateTime, 
EndDateTime, 
DisplayText, 
Portable, 
MobilityStatus, 
ClinicalImpression, 
TotalExposures, 
WasBariumUsed, 
IntravascularContrast,
RadiologyProcedure,
ImagingType,
PerformingTechnician
)
SELECT  
PAT.PatientId,
FMP.FamilyMemberPrefixCode + '/' +
PAT.SponsorSSN,
PAT.PatientIdentifier,
ENC.EREntryNumber,   
ORD.OrderKey, 
ORD.OrderNumber, 
'Radiology (5.00)' AS OrderType,
OPRO.ProviderName, 
OrderDateTime,
ArrivalDateTime,
ExamDateTime,
DepartureDateTime,
RADIOLOGY_EXAM.StartDateTime,
EndDateTime,
DisplayText,
Portable,
ISNULL(MOB.MobilityStatusDesc,'NA') AS MobilityStatus,
ORD.ClinicalImpression,
RADIOLOGY_EXAM.TotalExposures,
RADIOLOGY_EXAM.WasBariumUsed,
RADIOLOGY_EXAM.IntravascularContrast,
RADIOLOGY.RadiologyDesc,
ISNULL(IMG.ImagingTypeDesc,0),
ISNULL(TECH.ProviderName,0)
FROM PATIENT_ORDER AS ORD
INNER JOIN PATIENT AS PAT
ON ORD.PatientId = PAT.PatientId
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP
ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
INNER JOIN PROVIDER AS OPRO
ON ORD.OrderingProviderId = OPRO.ProviderId
LEFT OUTER JOIN PROVIDER AS RPRO
ON ORD.RequestingProviderId = RPRO.ProviderId
INNER JOIN RADIOLOGY_EXAM
ON ORD.OrderId = RADIOLOGY_EXAM.OrderId
INNER JOIN RADIOLOGY
ON RADIOLOGY_EXAM.RadiologyId = RADIOLOGY.RadiologyId
INNER JOIN CPT
ON RADIOLOGY.CptId = CPT.CptId
LEFT OUTER JOIN MOBILITY_STATUS AS MOB
ON ORD.MobilityStatusId = MOB.MobilityStatusId
LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC
ON ORD.PatientEncounterId = ENC.PatientEncounterId
LEFT OUTER JOIN IMAGING_TYPE AS IMG
ON RADIOLOGY_EXAM.ImagingTypeId = IMG.ImagingTypeId
LEFT OUTER JOIN PROVIDER AS TECH
ON RADIOLOGY_EXAM.PerformingTechnicianId = TECH.ProviderId
WHERE     (ORD.PatientEncounterId IN
  (SELECT     PatientEncounterId
    FROM          PATIENT_ENCOUNTER
    WHERE      (AppointmentDateTime > @sdate)
    AND AppointmentDateTime < @edate
     AND (HospitalLocationId = 174)))
AND OrderTypeId = 15