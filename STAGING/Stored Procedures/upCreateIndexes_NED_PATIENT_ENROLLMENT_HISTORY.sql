﻿CREATE PROCEDURE [dbo].[upCreateIndexes_NED_PATIENT$ENROLLMENT_HISTORY] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_NED_PATIENT$ENROLLMENT_HISTORY')
		DROP INDEX NED_PATIENT$ENROLLMENT_HISTORY.ind_NED_PATIENT$ENROLLMENT_HISTORY
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT$ENROLLMENT_HISTORY')
		DROP INDEX NED_PATIENT$ENROLLMENT_HISTORY.IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT$ENROLLMENT_HISTORY
		
	CREATE INDEX 	IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT$ENROLLMENT_HISTORY
	ON 			NED_PATIENT$ENROLLMENT_HISTORY(KEY_NED_PATIENT$ENROLLMENT_HISTORY)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT')
		DROP INDEX NED_PATIENT$ENROLLMENT_HISTORY.IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT				
	CREATE INDEX 	IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT
	ON 			NED_PATIENT$ENROLLMENT_HISTORY(KEY_NED_PATIENT)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_NED_PATIENT$ENROLLMENT_HISTORY_DMIS_ID_IEN')
		DROP INDEX NED_PATIENT$ENROLLMENT_HISTORY.IX_NED_PATIENT$ENROLLMENT_HISTORY_DMIS_ID_IEN				
	CREATE INDEX 	IX_NED_PATIENT$ENROLLMENT_HISTORY_DMIS_ID_IEN
	ON 			NED_PATIENT$ENROLLMENT_HISTORY(DMIS_ID_IEN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_NED_PATIENT$ENROLLMENT_HISTORY_ENROLLMENT_HISTORY_NUMBER')
		DROP INDEX NED_PATIENT$ENROLLMENT_HISTORY.IX_NED_PATIENT$ENROLLMENT_HISTORY_ENROLLMENT_HISTORY_NUMBER				
	CREATE INDEX 	IX_NED_PATIENT$ENROLLMENT_HISTORY_ENROLLMENT_HISTORY_NUMBER
	ON 			NED_PATIENT$ENROLLMENT_HISTORY(ENROLLMENT_HISTORY_NUMBER)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT')
		DROP INDEX NED_PATIENT$ENROLLMENT_HISTORY.IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT
	CREATE CLUSTERED INDEX 	IX_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT$ENROLLMENT_HISTORY_KEY_NED_PATIENT
	ON 			NED_PATIENT$ENROLLMENT_HISTORY(KEY_NED_PATIENT$ENROLLMENT_HISTORY,KEY_NED_PATIENT)
	WITH 			FILLFACTOR = 100
