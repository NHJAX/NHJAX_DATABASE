﻿create PROCEDURE [dbo].[upCreateIndexes_LAB_RESULT$CYTOLOGY_GYN] AS
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_LAB_RESULT$CYTOLOGY_GYN')
		DROP INDEX LAB_RESULT$CYTOLOGY_GYN.ind_LAB_RESULT$CYTOLOGY_GYN

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$CYTOLOGY_GYN_KEY_LAB_RESULT')
		DROP INDEX LAB_RESULT$CYTOLOGY_GYN.IX_LAB_RESULT$CYTOLOGY_GYN_KEY_LAB_RESULT
		
	CREATE INDEX 	IX_LAB_RESULT$CYTOLOGY_GYN_KEY_LAB_RESULT
	ON 			LAB_RESULT$CYTOLOGY_GYN(KEY_LAB_RESULT)
	WITH 			FILLFACTOR = 100
				
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$CYTOLOGY_GYN_ORDER_REFERENCE_IEN')
		DROP INDEX LAB_RESULT$CYTOLOGY_GYN.IX_LAB_RESULT$CYTOLOGY_GYN_ORDER_REFERENCE_IEN
		
	CREATE INDEX 	IX_LAB_RESULT$CYTOLOGY_GYN_ORDER_REFERENCE_IEN
	ON 			LAB_RESULT$CYTOLOGY_GYN(ORDER_REFERENCE_IEN)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$CYTOLOGY_GYN_ORDER_TASK_IEN')
		DROP INDEX LAB_RESULT$CYTOLOGY_GYN.IX_LAB_RESULT$CYTOLOGY_GYN_ORDER_TASK_IEN
		
	CREATE CLUSTERED INDEX 	IX_LAB_RESULT$CYTOLOGY_GYN_ORDER_TASK_IEN
	ON 			LAB_RESULT$CYTOLOGY_GYN(ORDER_TASK_IEN)
	WITH 			FILLFACTOR = 100
