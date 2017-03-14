﻿CREATE PROCEDURE [dbo].[upCreateIndexes_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR] AS
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR')
		DROP INDEX LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.ind_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_KEY_LAB_RESULT')
		DROP INDEX LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_KEY_LAB_RESULT
		
	CREATE INDEX 	IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_KEY_LAB_RESULT
	ON 			LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR(KEY_LAB_RESULT)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_APPENDED_AMENDED_RNR_DATE_TIME')
		DROP INDEX LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_APPENDED_AMENDED_RNR_DATE_TIME
		
	CREATE CLUSTERED INDEX 	IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_APPENDED_AMENDED_RNR_DATE_TIME
	ON 			LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR(APPENDED_AMENDED_RNR_DATE_TIME)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_KEY_LAB_RESULT$CLINICAL_CHEMISTRY')
		DROP INDEX LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_KEY_LAB_RESULT$CLINICAL_CHEMISTRY
		
	CREATE INDEX 	IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_KEY_LAB_RESULT$CLINICAL_CHEMISTRY
	ON 			LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR(KEY_LAB_RESULT$CLINICAL_CHEMISTRY)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_MULTI_KEY')
		DROP INDEX LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_MULTI_KEY
		
	CREATE INDEX 	IX_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR_MULTI_KEY
	ON 			LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR(KEY_LAB_RESULT,KEY_LAB_RESULT$CLINICAL_CHEMISTRY)
	WITH 			FILLFACTOR = 100
