
CREATE PROCEDURE [dbo].[procCOPY_E_PHARMACY_ORDER]

AS

TRUNCATE TABLE ODS_COPY.dbo.E_PHARMACY_ORDER

DECLARE @sdate datetime
DECLARE @edate datetime

SET @sdate = dbo.StartOfDay('2014-01-01')
SET @edate = dbo.EndOfDay(GETDATE())

INSERT INTO ODS_COPY.dbo.E_PHARMACY_ORDER
(
PatientId,
FMP_SSN,
PatientIdentifier,
EREntryNumber,
OrderKey, 
OrderNumber, 
Provider, 
OrderDateTime,
Drug, 
Sig,
LoggedBy, 
FillDateTime, 
LabelPrintDateTime,
DaysSupply,
Quantity,
Refills,
NDCCode,
DEA,
Strength,
[Route],
Form,
TherapeuticClass,
AHFS,
Pharmacy
)

SELECT 
PAT.PatientId,
FMP.FamilyMemberPrefixCode + '/' +
PAT.SponsorSSN,
PAT.PatientIdentifier,
ENC.EREntryNumber,    
ORD.OrderKey, 
ORD.OrderNumber, 
PROVIDER.ProviderName,
ORD.OrderDateTime,
DRUG.DrugDesc,
PRE.Sig,
FILL.LoggedBy,
FILL.FillDate,
FILL.LabelPrintDateTime,
PRE.DaysSupply,
PRE.Quantity,
PRE.Refills,
DRUG.NDCNumber,
DRUG.DrugScheduleCode,
DRUG.DosageStrength,
ISNULL(RTE.DrugRouteDesc,''),
ISNULL(FRM.DrugFormDesc,''),
ISNULL(TC.TherapeuticClassDesc,''),
ISNULL(AHFS.AHFSClassificationDesc,''),
ISNULL(PHARMACY.PharmacyDesc,'')
FROM PATIENT_ORDER AS ORD
INNER JOIN PATIENT AS PAT
ON ORD.PatientId = PAT.PatientId
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP
ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
INNER JOIN PRESCRIPTION AS PRE
ON ORD.OrderId = PRE.OrderId
INNER JOIN PRESCRIPTION_FILL_DATE AS FILL
ON PRE.PrescriptionId = FILL.PrescriptionId
LEFT OUTER JOIN DRUG
ON PRE.DrugId = DRUG.DrugId
INNER JOIN PROVIDER
ON PRE.ProviderId = PROVIDER.ProviderId
LEFT OUTER JOIN PATIENT_ENCOUNTER AS ENC
ON ORD.PatientEncounterId = ENC.PatientEncounterId
LEFT OUTER JOIN DRUG_ROUTE AS RTE
ON DRUG.DrugRouteId = RTE.DrugRouteId
LEFT OUTER JOIN DRUG_FORM AS FRM
ON DRUG.DrugFormId = FRM.DrugFormId
LEFT OUTER JOIN THERAPEUTIC_CLASS AS TC
ON DRUG.TherapeuticClassId = TC.TherapeuticClassId
LEFT OUTER JOIN AHFS_CLASSIFICATION AS AHFS
ON DRUG.AHFSClassificationId = AHFS.AHFSClassificationId
LEFT OUTER JOIN PHARMACY
ON PRE.PharmacyId = PHARMACY.PharmacyId
WHERE     (ORD.PatientEncounterId IN
  (SELECT     PatientEncounterId
    FROM          PATIENT_ENCOUNTER
    WHERE      (AppointmentDateTime > @sdate)
    AND AppointmentDateTime < @edate
     AND (HospitalLocationId = 174)))
AND OrderTypeId = 16