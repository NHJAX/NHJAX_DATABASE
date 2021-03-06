﻿CREATE PROCEDURE [dbo].[upCreateIndexes_ALLERGIES_DEFINITIONS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ALLERGIES_DEFINITIONS')
		DROP INDEX ALLERGIES_DEFINITIONS.ind_ALLERGIES_DEFINITIONS
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ALLERGIES_DEFINITIONS_KEY_ALLERGIES_DEFINITIONS')
		DROP INDEX ALLERGIES_DEFINITIONS.IX_ALLERGIES_DEFINITIONS_KEY_ALLERGIES_DEFINITIONS
		                                                                
	CREATE CLUSTERED INDEX 	IX_ALLERGIES_DEFINITIONS_KEY_ALLERGIES_DEFINITIONS
	ON 			ALLERGIES_DEFINITIONS(KEY_ALLERGIES_DEFINITIONS)
	WITH 			FILLFACTOR = 100
