﻿CREATE PROCEDURE [dbo].[upCreateIndexes_USER_] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_USER_')
		DROP INDEX USER_.ind_USER_
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_USER__KEY_USER')
		DROP INDEX USER_.IX_USER__KEY_USER
		
	CREATE INDEX 	IX_USER__KEY_USER
	ON 			USER_(KEY_USER)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_USER__PROVIDER_IEN')
		DROP INDEX USER_.IX_USER__PROVIDER_IEN
		
	CREATE INDEX 	IX_USER__PROVIDER_IEN
	ON 			USER_(PROVIDER_IEN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_USER__TERMINATION_DATE')
		DROP INDEX USER_.IX_USER__TERMINATION_DATE
		
	CREATE CLUSTERED INDEX 	IX_USER__TERMINATION_DATE
	ON 			USER_(TERMINATION_DATE)
	WITH 			FILLFACTOR = 100
