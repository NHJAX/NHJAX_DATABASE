create PROCEDURE [dbo].[procSTG_IMMUNIZATIONS_Insert]

AS
	SET NOCOUNT ON;
	
TRUNCATE TABLE IMMUNIZATIONS;
	
INSERT INTO IMMUNIZATIONS
(     
	FullName, 
	DOB, 
	FMP, 
	FMPSponsorSSN, 
	SponsorSSN, 
	ImmunizationVaccineName, 
	ImmunizationDate, 
	ImmunizationDateNextDue, 
	ImmunizationSeries,
	ImmunizationExemption, 
	ImmunizationExemptionExpirDate, 
	ImmunizationDosage, 
	ImmunizationLotNumber, 
	ImmunizationManufacturer, 
	ImmunizationCode, 
	ImmunizationTypeId
)
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization ICD] AS ImmunizationCode,
	1 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK1
WHERE [Immunization ICD] IS NOT NULL
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization ICD] AS ImmunizationCode,
	1 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK2
WHERE [Immunization ICD] IS NOT NULL
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization ICD] AS ImmunizationCode,
	1 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK3
WHERE [Immunization ICD] IS NOT NULL
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization ICD] AS ImmunizationCode,
	1 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK4
WHERE [Immunization ICD] IS NOT NULL  
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization CPT] AS ImmunizationCode,
	2 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK1
WHERE [Immunization CPT] IS NOT NULL
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization CPT] AS ImmunizationCode,
	2 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK2
WHERE [Immunization CPT] IS NOT NULL
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization CPT] AS ImmunizationCode,
	2 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK3
WHERE [Immunization CPT] IS NOT NULL
UNION
SELECT     
	[Full Name] AS FullName, 
	DOB, FMP, 
	[FMP Sponsor SSN] AS FmpSponsorSSN, 
	[Sponsor SSN] AS SponsorSSN, 
	[Immunization Vaccine Name] AS ImmunizationVaccineName, 
	[Immunization Date] AS ImmunizationDate, 
	[Immunization Date Next Due] AS ImmunizationDateNextDue, 
	[Immunization Series] AS ImmunizationSeries, 
	[Immunization Exemption] AS ImmunizationExemption, 
	[Immunization Exemption Expir# Date] AS ImmunizationExemptionExpirDate, 
	[Immunization Dosage] AS ImmunizationDosage, 
	[Immunization Lot Number of Vaccine] AS ImmunizationLotNumber, 
	[Immunization Manufacturer] AS ImmunizationManufacturer, 
	[Immunization CPT] AS ImmunizationCode,
	2 AS ImmunizationTypeId
FROM IMMUNIZATIONS_WEEK4
WHERE [Immunization CPT] IS NOT NULL
