CREATE PROCEDURE [dbo].[upCreateIndexes_ORDER_TASK] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ORDER_TASK')
		DROP INDEX ORDER_TASK.ind_ORDER_TASK
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_TASK_KEY_ORDER_TASK')
		DROP INDEX ORDER_TASK.IX_ORDER_TASK_KEY_ORDER_TASK
		                                                                
	CREATE CLUSTERED INDEX 	IX_ORDER_TASK_KEY_ORDER_TASK
	ON 			ORDER_TASK(KEY_ORDER_TASK)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_TASK_ORDER_IEN')
		DROP INDEX ORDER_TASK.IX_ORDER_TASK_ORDER_IEN
		                                                                
	CREATE INDEX 	IX_ORDER_TASK_ORDER_IEN
	ON 			ORDER_TASK(ORDER_IEN)
	WITH 			FILLFACTOR = 100
