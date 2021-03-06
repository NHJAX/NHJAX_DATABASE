﻿CREATE PROCEDURE [dbo].[upCreateIndexes_APPOINTMENT_DETAIL_CODES] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_APPOINTMENT_DETAIL_CODES')
		DROP INDEX APPOINTMENT_DETAIL_CODES.ind_APPOINTMENT_DETAIL_CODES
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_APPOINTMENT_DETAIL_CODES_KEY_APPOINTMENT_DETAIL_CODES')
		DROP INDEX APPOINTMENT_DETAIL_CODES.IX_APPOINTMENT_DETAIL_CODES_KEY_APPOINTMENT_DETAIL_CODES
		                                                                
	CREATE INDEX 	IX_APPOINTMENT_DETAIL_CODES_KEY_APPOINTMENT_DETAIL_CODES
	ON 			APPOINTMENT_DETAIL_CODES(KEY_APPOINTMENT_DETAIL_CODES)
	WITH 			FILLFACTOR = 100
