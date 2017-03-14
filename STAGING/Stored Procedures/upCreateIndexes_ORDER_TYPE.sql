CREATE PROCEDURE [dbo].[upCreateIndexes_ORDER_TYPE] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ORDER_TYPE')
		DROP INDEX ORDER_TYPE.ind_ORDER_TYPE
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_TYPE_KEY_ORDER_TYPE')
		DROP INDEX ORDER_TYPE.IX_ORDER_TYPE_KEY_ORDER_TYPE
		                                                                
	CREATE INDEX 	IX_ORDER_TYPE_KEY_ORDER_TYPE
	ON 			ORDER_TYPE(KEY_ORDER_TYPE)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_TYPE_NUMBER_')
		DROP INDEX ORDER_TYPE.IX_ORDER_TYPE_NUMBER_
		                                                                
	CREATE INDEX 	IX_ORDER_TYPE_NUMBER_
	ON 			ORDER_TYPE(NUMBER_)
	WITH 			FILLFACTOR = 100
