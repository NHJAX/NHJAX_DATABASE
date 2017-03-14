﻿CREATE PROCEDURE [dbo].[upCreateIndexes_PATIENT] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_PATIENT')
		DROP INDEX PATIENT.ind_PATIENT
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PATIENT_KEY_PATIENT')
		DROP INDEX PATIENT.IX_PATIENT_KEY_PATIENT
		
	CREATE INDEX 	IX_PATIENT_KEY_PATIENT
	ON 			PATIENT(KEY_PATIENT)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PATIENT_NAME')
		DROP INDEX PATIENT.IX_PATIENT_NAME				
	CREATE INDEX 	IX_PATIENT_NAME
	ON 			PATIENT(NAME)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PATIENT_SSN')
		DROP INDEX PATIENT.IX_PATIENT_SSN				
	CREATE INDEX 	IX_PATIENT_SSN
	ON 			PATIENT(SSN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PATIENT_SPONSOR_SSN')
		DROP INDEX PATIENT.IX_PATIENT_SPONSOR_SSN				
	CREATE INDEX 	IX_PATIENT_SPONSOR_SSN
	ON 			PATIENT(SPONSOR_SSN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PATIENT_PROVIDER_IEN')
		DROP INDEX PATIENT.IX_PATIENT_PROVIDER_IEN				
	CREATE INDEX 	IX_PATIENT_PROVIDER_IEN
	ON 			PATIENT(PROVIDER_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PATIENT_FMP_IEN')
		DROP INDEX PATIENT.IX_PATIENT_FMP_IEN				
	CREATE INDEX 	IX_PATIENT_FMP_IEN
	ON 			PATIENT(FMP_IEN)
	WITH 			FILLFACTOR = 100
