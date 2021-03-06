﻿CREATE PROCEDURE [dbo].[upCreateIndexes_LAB_RESULT$BACTERIOLOGY] AS
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_LAB_RESULT$BACTERIOLOGY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY.ind_LAB_RESULT$BACTERIOLOGY

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY_KEY_LAB_RESULT')
		DROP INDEX LAB_RESULT$BACTERIOLOGY.IX_LAB_RESULT$BACTERIOLOGY_KEY_LAB_RESULT
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY_KEY_LAB_RESULT
	ON 			LAB_RESULT$BACTERIOLOGY(KEY_LAB_RESULT)
	WITH 			FILLFACTOR = 100
				
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY_KEY_LAB_RESULT$BACTERIOLOGY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY.IX_LAB_RESULT$BACTERIOLOGY_KEY_LAB_RESULT$BACTERIOLOGY
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY_KEY_LAB_RESULT$BACTERIOLOGY
	ON 			LAB_RESULT$BACTERIOLOGY(KEY_LAB_RESULT$BACTERIOLOGY)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY_MULTIKEY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY.IX_LAB_RESULT$BACTERIOLOGY_MULTIKEY
		
	CREATE CLUSTERED INDEX 	IX_LAB_RESULT$BACTERIOLOGY_MULTIKEY
	ON 			LAB_RESULT$BACTERIOLOGY(KEY_LAB_RESULT,KEY_LAB_RESULT$BACTERIOLOGY)
	WITH 			FILLFACTOR = 100
