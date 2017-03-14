CREATE PROCEDURE [dbo].[upCreateIndexes_LAB_STATUS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_LAB_STATUS')
		DROP INDEX LAB_STATUS.ind_LAB_STATUS
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_LAB_STATUS_KEY_LAB_STATUS')
		DROP INDEX LAB_STATUS.IX_LAB_STATUS_KEY_LAB_STATUS
		                                                                
	CREATE INDEX 	IX_LAB_STATUS_KEY_LAB_STATUS
	ON 			LAB_STATUS(KEY_LAB_STATUS)
	WITH 			FILLFACTOR = 100
