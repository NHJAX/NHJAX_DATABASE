﻿CREATE PROCEDURE [dbo].[upCreateIndexes_ENCOUNTER$ICD_OPERATIONS_PROCEDURES] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ENCOUNTER$ICD_OPERATIONS_PROCEDURES')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.ind_ENCOUNTER$ICD_OPERATIONS_PROCEDURES
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES
	CREATE INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(KEY_ENCOUNTER$ICD_OPERATIONS_PROCEDURES)
	WITH			FILLFACTOR = 100
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER
	CREATE INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_KEY_ENCOUNTER
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(KEY_ENCOUNTER)
	WITH			FILLFACTOR = 100
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_NUMBER_')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_NUMBER_
	CREATE INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_NUMBER_
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(NUMBER_)
	WITH			FILLFACTOR = 100
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ICD_OPERATIONS_PROCEDURES_IEN')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ICD_OPERATIONS_PROCEDURES_IEN
	CREATE INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ICD_OPERATIONS_PROCEDURES_IEN
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(ICD_OPERATIONS_PROCEDURES_IEN)
	WITH			FILLFACTOR = 100
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_DATE_TIME')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_DATE_TIME
	CREATE CLUSTERED INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_DATE_TIME
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(DATE_TIME)
	WITH			FILLFACTOR = 100
	
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_SURGEON_IEN')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_SURGEON_IEN
	CREATE INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_SURGEON_IEN
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(SURGEON_IEN)
	WITH			FILLFACTOR = 100

	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ANESTHESIOLOGIST_IEN')
		DROP INDEX ENCOUNTER$ICD_OPERATIONS_PROCEDURES.IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ANESTHESIOLOGIST_IEN
	CREATE INDEX		IX_ENCOUNTER$ICD_OPERATIONS_PROCEDURES_ANESTHESIOLOGIST_IEN
	ON			ENCOUNTER$ICD_OPERATIONS_PROCEDURES(ANESTHESIOLOGIST_IEN)
	WITH			FILLFACTOR = 100
