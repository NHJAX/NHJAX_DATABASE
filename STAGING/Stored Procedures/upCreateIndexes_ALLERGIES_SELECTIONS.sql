﻿CREATE PROCEDURE [dbo].[upCreateIndexes_ALLERGIES_SELECTIONS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ALLERGIES_SELECTIONS')
		DROP INDEX ALLERGIES_SELECTIONS.ind_ALLERGIES_SELECTIONS
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ALLERGIES_SELECTIONS_KEY_ALLERGIES_SELECTIONS')
		DROP INDEX ALLERGIES_SELECTIONS.IX_ALLERGIES_SELECTIONS_KEY_ALLERGIES_SELECTIONS
		                                                                
	CREATE INDEX 	IX_ALLERGIES_SELECTIONS_KEY_ALLERGIES_SELECTIONS
	ON 			ALLERGIES_SELECTIONS(KEY_ALLERGIES_SELECTIONS)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ALLERGIES_SELECTIONS_ALLERGY_DEFINITIONS_IEN')
		DROP INDEX ALLERGIES_SELECTIONS.IX_ALLERGIES_SELECTIONS_ALLERGY_DEFINITIONS_IEN
		                                                                
	CREATE CLUSTERED INDEX 	IX_ALLERGIES_SELECTIONS_ALLERGY_DEFINITIONS_IEN
	ON 			ALLERGIES_SELECTIONS(ALLERGY_DEFINITIONS_IEN)
	WITH 			FILLFACTOR = 100