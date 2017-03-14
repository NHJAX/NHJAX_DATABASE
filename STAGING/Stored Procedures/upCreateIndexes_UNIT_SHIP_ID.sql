CREATE PROCEDURE [dbo].[upCreateIndexes_UNIT_SHIP_ID] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_UNIT_SHIP_ID')
		DROP INDEX UNIT_SHIP_ID.ind_UNIT_SHIP_ID
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_UNIT_SHIP_ID_CODE')
		DROP INDEX UNIT_SHIP_ID.IX_UNIT_SHIP_ID_CODE
		                                                                
	CREATE INDEX 	IX_UNIT_SHIP_ID_CODE
	ON 			UNIT_SHIP_ID([CODE])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_UNIT_SHIP_ID_KEY_UNIT_SHIP_ID')
		DROP INDEX UNIT_SHIP_ID.IX_UNIT_SHIP_ID_KEY_UNIT_SHIP_ID
		                                                                
	CREATE INDEX 	IX_UNIT_SHIP_ID_KEY_UNIT_SHIP_ID
	ON 			UNIT_SHIP_ID([KEY_UNIT_SHIP_ID])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_UNIT_SHIP_ID_BRANCH_OF_SERVICE_IEN')
		DROP INDEX UNIT_SHIP_ID.IX_UNIT_SHIP_ID_BRANCH_OF_SERVICE_IEN
		                                                                
	CREATE INDEX 	IX_UNIT_SHIP_ID_BRANCH_OF_SERVICE_IEN
	ON 			UNIT_SHIP_ID([BRANCH_OF_SERVICE_IEN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_UNIT_SHIP_ID_UNIT_LOCATION_IEN')
		DROP INDEX UNIT_SHIP_ID.IX_UNIT_SHIP_ID_UNIT_LOCATION_IEN
		                                                                
	CREATE INDEX 	IX_UNIT_SHIP_ID_UNIT_LOCATION_IEN
	ON 			UNIT_SHIP_ID([UNIT_LOCATION_IEN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_UNIT_SHIP_ID_NAME')
		DROP INDEX UNIT_SHIP_ID.IX_UNIT_SHIP_ID_NAME
		                                                                
	CREATE INDEX 	IX_UNIT_SHIP_ID_NAME
	ON 			UNIT_SHIP_ID([NAME])
	WITH 			FILLFACTOR = 100
