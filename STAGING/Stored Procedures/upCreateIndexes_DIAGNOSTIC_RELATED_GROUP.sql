﻿CREATE PROCEDURE [dbo].[upCreateIndexes_DIAGNOSTIC_RELATED_GROUP] AS
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_DIAGNOSTIC_RELATED_GROUP')
		DROP INDEX DIAGNOSTIC_RELATED_GROUP.ind_DIAGNOSTIC_RELATED_GROUP
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_DIAGNOSTIC_RELATED_GROUP_KEY_DIAGNOSTIC_RELATED_GROUP')
		DROP INDEX DIAGNOSTIC_RELATED_GROUP.IX_DIAGNOSTIC_RELATED_GROUP_KEY_DIAGNOSTIC_RELATED_GROUP
		
	CREATE INDEX 	IX_DIAGNOSTIC_RELATED_GROUP_KEY_DIAGNOSTIC_RELATED_GROUP
	ON 			DIAGNOSTIC_RELATED_GROUP(KEY_DIAGNOSTIC_RELATED_GROUP)
	WITH 			FILLFACTOR = 100
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_DIAGNOSTIC_RELATED_GROUP_DRG_CODE')
		DROP INDEX DIAGNOSTIC_RELATED_GROUP.IX_DIAGNOSTIC_RELATED_GROUP_DRG_CODE				
	CREATE INDEX 	IX_DIAGNOSTIC_RELATED_GROUP_DRG_CODE
	ON 			DIAGNOSTIC_RELATED_GROUP(DRG_CODE)
	WITH 			FILLFACTOR = 100