CREATE PROCEDURE [dbo].[upCreateIndexes_DMIS_ID_CODES] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_DMIS_ID_CODES')
		DROP INDEX DMIS_ID_CODES.ind_DMIS_ID_CODES
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_DMIS_ID_CODES_KEY_DMIS_ID_CODES')
		DROP INDEX DMIS_ID_CODES.IX_DMIS_ID_CODES_KEY_DMIS_ID_CODES
		                                                                
	CREATE INDEX 	IX_DMIS_ID_CODES_KEY_DMIS_ID_CODES
	ON 			DMIS_ID_CODES(KEY_DMIS_ID_CODES)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_DMIS_ID_CODES_DMIS_ID')
		DROP INDEX DMIS_ID_CODES.IX_DMIS_ID_CODES_DMIS_ID
		                                                                
	CREATE INDEX 	IX_DMIS_ID_CODES_DMIS_ID
	ON 			DMIS_ID_CODES(DMIS_ID)
	WITH 			FILLFACTOR = 100
