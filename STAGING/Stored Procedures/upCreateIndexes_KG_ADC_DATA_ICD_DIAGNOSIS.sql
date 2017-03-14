﻿CREATE PROCEDURE [dbo].[upCreateIndexes_KG_ADC_DATA$ICD_DIAGNOSIS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_KG_ADC_DATA$ICD_DIAGNOSIS')
		DROP INDEX KG_ADC_DATA$ICD_DIAGNOSIS.ind_KG_ADC_DATA$ICD_DIAGNOSIS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$ICD_DIAGNOSIS_KEY_KG_ADC_DATA$ICD_DIAGNOSIS')
		DROP INDEX KG_ADC_DATA$ICD_DIAGNOSIS.IX_KG_ADC_DATA$ICD_DIAGNOSIS_KEY_KG_ADC_DATA$ICD_DIAGNOSIS
		
	CREATE INDEX 	IX_KG_ADC_DATA$ICD_DIAGNOSIS_KEY_KG_ADC_DATA$ICD_DIAGNOSIS
	ON 			KG_ADC_DATA$ICD_DIAGNOSIS(KEY_KG_ADC_DATA$ICD_DIAGNOSIS)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$ICD_DIAGNOSIS_KEY_KG_ADC_DATA')
		DROP INDEX KG_ADC_DATA$ICD_DIAGNOSIS.IX_KG_ADC_DATA$ICD_DIAGNOSIS_KEY_KG_ADC_DATA		
	CREATE INDEX 	IX_KG_ADC_DATA$ICD_DIAGNOSIS_KEY_KG_ADC_DATA
	ON 			KG_ADC_DATA$ICD_DIAGNOSIS(KEY_KG_ADC_DATA)
	WITH 			FILLFACTOR = 100
				
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$ICD_DIAGNOSIS_ICD_DIAGNOSIS_IEN')
		DROP INDEX KG_ADC_DATA$ICD_DIAGNOSIS.IX_KG_ADC_DATA$ICD_DIAGNOSIS_ICD_DIAGNOSIS_IEN
	CREATE INDEX 	IX_KG_ADC_DATA$ICD_DIAGNOSIS_ICD_DIAGNOSIS_IEN
	ON 			KG_ADC_DATA$ICD_DIAGNOSIS(ICD_DIAGNOSIS_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$ICD_DIAGNOSIS_ICD_CODE')
		DROP INDEX KG_ADC_DATA$ICD_DIAGNOSIS.IX_KG_ADC_DATA$ICD_DIAGNOSIS_ICD_CODE				
	CREATE INDEX 	IX_KG_ADC_DATA$ICD_DIAGNOSIS_ICD_CODE
	ON 			KG_ADC_DATA$ICD_DIAGNOSIS(ICD_CODE)
	WITH 			FILLFACTOR = 100
