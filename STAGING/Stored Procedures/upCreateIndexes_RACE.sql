Create PROCEDURE [dbo].[upCreateIndexes_RACE] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_RACE')
		DROP INDEX RACE.ind_RACE
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RACE_KEY_RACE')
		DROP INDEX RACE.IX_RACE_KEY_RACE
		                                                                
	CREATE INDEX 	IX_RACE_KEY_RACE
	ON 			RACE(KEY_RACE)
	WITH 			FILLFACTOR = 100
