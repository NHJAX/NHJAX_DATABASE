﻿CREATE PROCEDURE [dbo].[upCreateIndexes_PRESCRIPTION] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_PRESCRIPTION')
		DROP INDEX PRESCRIPTION.ind_PRESCRIPTION

	IF EXISTS 
	(
	  SELECT si.name
	  FROM sysindexes si
	  INNER JOIN sysobjects so ON si.id = so.id 
	  WHERE si.name = 'IX_PRESCRIPTION_KEY_PRESCRIPTION' and so.name = 'PRESCRIPTION'
	)
     DROP INDEX PRESCRIPTION.IX_PRESCRIPTION_KEY_PRESCRIPTION
		
	CREATE INDEX 	IX_PRESCRIPTION_KEY_PRESCRIPTION
	ON 			PRESCRIPTION(KEY_PRESCRIPTION)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS 
	(
		SELECT si.name
	  FROM sysindexes si
	  INNER JOIN sysobjects so ON si.id = so.id 
	  WHERE si.name = 'IX_PRESCRIPTION_PATIENT_IEN' and so.name = 'PRESCRIPTION'
	)
			DROP INDEX PRESCRIPTION.IX_PRESCRIPTION_PATIENT_IEN				
			CREATE INDEX 	IX_PRESCRIPTION_PATIENT_IEN
			ON 			PRESCRIPTION(PATIENT_IEN)
			WITH 			FILLFACTOR = 100
		
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PRESCRIPTION_PROVIDER_IEN')
		DROP INDEX PRESCRIPTION.IX_PRESCRIPTION_PROVIDER_IEN				
	CREATE INDEX 	IX_PRESCRIPTION_PROVIDER_IEN
	ON 			PRESCRIPTION(PROVIDER_IEN)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PRESCRIPTION_DRUG_IEN')
		DROP INDEX PRESCRIPTION.IX_PRESCRIPTION_DRUG_IEN				
	CREATE INDEX 	IX_PRESCRIPTION_DRUG_IEN
	ON 			PRESCRIPTION(DRUG_IEN)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PRESCRIPTION_EXPIRATION_DATE')
		DROP INDEX PRESCRIPTION.IX_PRESCRIPTION_EXPIRATION_DATE				
	CREATE CLUSTERED INDEX 	IX_PRESCRIPTION_EXPIRATION_DATE
	ON 			PRESCRIPTION(EXPIRATION_DATE)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PRESCRIPTION_LAST_FILL_DATE')
		DROP INDEX PRESCRIPTION.IX_PRESCRIPTION_LAST_FILL_DATE				
	CREATE INDEX 	IX_PRESCRIPTION_LAST_FILL_DATE
	ON 			PRESCRIPTION(LAST_FILL_DATE)
	WITH 			FILLFACTOR = 100