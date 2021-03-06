﻿CREATE PROCEDURE [dbo].[upCreateIndexes_LAB_RESULT$BACTERIOLOGY$TEST] AS
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_LAB_RESULT$BACTERIOLOGY$TEST')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST.ind_LAB_RESULT$BACTERIOLOGY$TEST

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST.IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT
	ON 			LAB_RESULT$BACTERIOLOGY$TEST(KEY_LAB_RESULT)
	WITH 			FILLFACTOR = 100
				
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT$BACTERIOLOGY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST.IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT$BACTERIOLOGY
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT$BACTERIOLOGY
	ON 			LAB_RESULT$BACTERIOLOGY$TEST(KEY_LAB_RESULT$BACTERIOLOGY)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT$BACTERIOLOGY$TEST')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST.IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT$BACTERIOLOGY$TEST
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST_KEY_LAB_RESULT$BACTERIOLOGY$TEST
	ON 			LAB_RESULT$BACTERIOLOGY$TEST(KEY_LAB_RESULT$BACTERIOLOGY$TEST)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST_TEST_IEN')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST.IX_LAB_RESULT$BACTERIOLOGY$TEST_TEST_IEN
		
	CREATE INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST_TEST_IEN
	ON 			LAB_RESULT$BACTERIOLOGY$TEST(TEST_IEN)
	WITH 			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_LAB_RESULT$BACTERIOLOGY$TEST_MULTIKEY')
		DROP INDEX LAB_RESULT$BACTERIOLOGY$TEST.IX_LAB_RESULT$BACTERIOLOGY$TEST_MULTIKEY
		
	CREATE CLUSTERED INDEX 	IX_LAB_RESULT$BACTERIOLOGY$TEST_MULTIKEY
	ON 			LAB_RESULT$BACTERIOLOGY$TEST(KEY_LAB_RESULT,KEY_LAB_RESULT$BACTERIOLOGY,TEST_IEN)
	WITH 			FILLFACTOR = 100
