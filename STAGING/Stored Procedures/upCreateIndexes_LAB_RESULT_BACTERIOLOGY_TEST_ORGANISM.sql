﻿CREATE PROCEDURE [dbo].[upCreateIndexes_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM] AS
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.ind_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT
	ON 			LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM(KEY_LAB_RESULT)
	WITH 			FILLFACTOR = 100
				
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY
	ON 			LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM(KEY_LAB_RESULT$BACTERIOLOGY)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY$TEST')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY$TEST
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY$TEST
	ON 			LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM(KEY_LAB_RESULT$BACTERIOLOGY$TEST)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_KEY_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM
	ON 			LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM(KEY_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_ORGANISM_IEN')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_ORGANISM_IEN
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_ORGANISM_IEN
	ON 			LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM(ORGANISM_IEN)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_MULTIKEY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM.IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_MULTIKEY
		
	CREATE CLUSTERED INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM_MULTIKEY
	ON 			LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM(KEY_LAB_RESULT,KEY_LAB_RESULT$BACTERIOLOGY,KEY_LAB_RESULT$BACTERIOLOGY$TEST,ORGANISM_IEN)
	WITH 			FILLFACTOR = 100
