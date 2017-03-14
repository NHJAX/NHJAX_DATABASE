﻿CREATE PROCEDURE [dbo].[upCreateIndexes_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE')
		DROP INDEX LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE.ind_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE')
		DROP INDEX LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE.IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE
		
	CREATE INDEX 	IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE
	ON 			LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE(KEY_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST')
		DROP INDEX LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE.IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST
	CREATE INDEX 	IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST
	ON 			LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE(KEY_LAB_TEST)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST$LAB_WORK_ELEMENT')
		DROP INDEX LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE.IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST$LAB_WORK_ELEMENT
	CREATE INDEX 	IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_KEY_LAB_TEST$LAB_WORK_ELEMENT
	ON 			LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE(KEY_LAB_TEST$LAB_WORK_ELEMENT)
	WITH 			FILLFACTOR = 100
	
				
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_CPT_CODE_IEN')
		DROP INDEX LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE.IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_CPT_CODE_IEN
		
	CREATE INDEX 	IX_LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE_CPT_CODE_IEN
	ON 			LAB_TEST$LAB_WORK_ELEMENT$CPT_CODE(CPT_CODE_IEN)
	WITH 			FILLFACTOR = 100
