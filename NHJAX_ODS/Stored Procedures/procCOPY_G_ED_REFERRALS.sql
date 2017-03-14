
CREATE PROCEDURE [dbo].[procCOPY_G_ED_REFERRALS]

AS

TRUNCATE TABLE ODS_COPY.dbo.G_ED_REFERRALS

DECLARE @sdate datetime
DECLARE @edate datetime

SET @sdate = dbo.StartOfDay('2014-01-01')
SET @edate = dbo.EndOfDay(GETDATE())

INSERT INTO ODS_COPY.dbo.G_ED_REFERRALS
(
	PatientId,
	FMP_SSN,
	PatientIdentifier,
	ReferralKey,
	ReferralDateTime,
	FromClinic,
	ToClinic,
	ReferringHCP,
	ReasonForReferral
)
SELECT 
	PATIENT.PatientId,
	FMP.FamilyMemberPrefixCode + '/' + PATIENT.SponsorSSN,
	PATIENT.PatientIdentifier,
	REF.ReferralKey,
	REF.ReferralDate,
	LOC.HospitalLocationName,
	LOC2.HospitalLocationName,
	PROVIDER.ProviderName,
	REF.ReasonForReferral
FROM REFERRAL AS REF
INNER JOIN PATIENT
ON REF.PatientId = PATIENT.PatientId
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP
ON PATIENT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
LEFT OUTER JOIN PROVIDER
ON PROVIDER.ProviderId = REF.ReferredByProviderId  
LEFT OUTER JOIN HOSPITAL_LOCATION AS LOC
ON LOC.HospitalLocationId = REF.ReferredByLocationId
LEFT OUTER JOIN HOSPITAL_LOCATION AS LOC2
ON LOC2.HospitalLocationId = REF.ReferredToLocationId
WHERE REF.PatientId IN (SELECT PatientId FROM ODS_COPY.dbo.B_ED_PATIENT)
AND REF.ReferralDate BETWEEN @sdate AND @edate