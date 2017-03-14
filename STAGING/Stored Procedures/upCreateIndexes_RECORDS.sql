﻿CREATE PROCEDURE [dbo].[upCreateIndexes_RECORDS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_RECORDS')
		DROP INDEX RECORDS.ind_RECORDS
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORDS_KEY_RECORDS')
		DROP INDEX RECORDS.IX_RECORDS_KEY_RECORDS
		                                                                
	CREATE INDEX 	IX_RECORDS_KEY_RECORDS
	ON 			RECORDS(KEY_RECORDS)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORDS_RECORD_NUMBER')
		DROP INDEX RECORDS.IX_RECORDS_RECORD_NUMBER
		                                                                
	CREATE INDEX 	IX_RECORDS_RECORD_NUMBER
	ON 			RECORDS(RECORD_NUMBER)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORDS_ASSOCIATED_ENTITY_IEN')
		DROP INDEX RECORDS.IX_RECORDS_ASSOCIATED_ENTITY_IEN
		                                                                
	CREATE INDEX 	IX_RECORDS_ASSOCIATED_ENTITY_IEN
	ON 			RECORDS(ASSOCIATED_ENTITY_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORDS_TYPE_OF_RECORD_IEN')
		DROP INDEX RECORDS.IX_RECORDS_TYPE_OF_RECORD_IEN
		                                                                
	CREATE INDEX 	IX_RECORDS_TYPE_OF_RECORD_IEN
	ON 			RECORDS(TYPE_OF_RECORD_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORDS_CURRENT_BORROWER_FILE_ROOM_IEN')
		DROP INDEX RECORDS.IX_RECORDS_CURRENT_BORROWER_FILE_ROOM_IEN
		                                                                
	CREATE INDEX 	IX_RECORDS_CURRENT_BORROWER_FILE_ROOM_IEN
	ON 			RECORDS(CURRENT_BORROWER_FILE_ROOM_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORDS_DATE_TIME_CHARGED_TO_BORROWER')
		DROP INDEX RECORDS.IX_RECORDS_DATE_TIME_CHARGED_TO_BORROWER
		                                                                
	CREATE INDEX 	IX_RECORDS_DATE_TIME_CHARGED_TO_BORROWER
	ON 			RECORDS(DATE_TIME_CHARGED_TO_BORROWER)
	WITH 			FILLFACTOR = 100
