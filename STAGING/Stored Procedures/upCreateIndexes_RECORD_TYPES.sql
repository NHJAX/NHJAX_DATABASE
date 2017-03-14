CREATE PROCEDURE [dbo].[upCreateIndexes_RECORD_TYPES] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_RECORD_TYPES')
		DROP INDEX RECORD_TYPES.ind_RECORD_TYPES
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RECORD_TYPES_KEY_RECORD_TYPES')
		DROP INDEX RECORD_TYPES.IX_RECORD_TYPES_KEY_RECORD_TYPES
		                                                                
	CREATE INDEX 	IX_RECORD_TYPES_KEY_RECORD_TYPES
	ON 			RECORD_TYPES(KEY_RECORD_TYPES)
	WITH 			FILLFACTOR = 100
