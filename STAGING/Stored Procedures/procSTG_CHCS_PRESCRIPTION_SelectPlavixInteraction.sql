﻿CREATE PROCEDURE [dbo].[procSTG_CHCS_PRESCRIPTION_SelectPlavixInteraction]

AS
	SET NOCOUNT ON;
SELECT DISTINCT 
PATIENT.NAME, 
FMP.FMP, 
PATIENT.SPONSOR_SSN, 
DRUG.NAME AS DrugName, 
PROVIDER.NAME AS ProviderName, 
PROVIDER_1.NAME AS PlavixProvider, 
PATIENT.STREET_ADDRESS, 
PATIENT.STREET_ADDRESS_2, 
PATIENT.STREET_ADDRESS_3, 
PATIENT.CITY, 
PATIENT.STATE_IEN, 
PATIENT.ZIP_CODE, 
PATIENT.PHONE, 
PATIENT.OFFICE_PHONE, 
NON.RX_#, 
PLAVIX.RX_# AS PlavixRX,
NON.LAST_FILL_DATE, 
PLAVIX.LAST_FILL_DATE AS PlavixFillDate
FROM vwSTG_CHCS_PRESCRIPTION_Plavix AS PLAVIX 
INNER JOIN vwSTG_CHCS_PRESCRIPTION_NonPlavix AS NON 
ON PLAVIX.PATIENT_IEN = NON.PATIENT_IEN 
INNER JOIN PATIENT 
ON PLAVIX.PATIENT_IEN = PATIENT.KEY_PATIENT 
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP 
ON PATIENT.FMP_IEN = FMP.KEY_FAMILY_MEMBER_PREFIX 
INNER JOIN DRUG 
ON NON.DRUG_IEN = DRUG.KEY_DRUG 
INNER JOIN PROVIDER 
ON NON.PROVIDER_IEN = PROVIDER.KEY_PROVIDER 
INNER JOIN PROVIDER AS PROVIDER_1 
ON PLAVIX.PROVIDER_IEN = PROVIDER_1.KEY_PROVIDER
ORDER BY PATIENT.NAME
