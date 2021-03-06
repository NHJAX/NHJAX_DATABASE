﻿CREATE PROCEDURE [dbo].[upCreateIndexes_APPOINTMENT_STATUS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_APPOINTMENT_STATUS')
		DROP INDEX APPOINTMENT_STATUS.ind_APPOINTMENT_STATUS
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_APPOINTMENT_STATUS_KEY_APPOINTMENT_STATUS')
		DROP INDEX APPOINTMENT_STATUS.IX_APPOINTMENT_STATUS_KEY_APPOINTMENT_STATUS
		                                                                
	CREATE INDEX 	IX_APPOINTMENT_STATUS_KEY_APPOINTMENT_STATUS
	ON 			APPOINTMENT_STATUS(KEY_APPOINTMENT_STATUS)
	WITH 			FILLFACTOR = 100
