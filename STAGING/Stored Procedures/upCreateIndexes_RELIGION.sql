﻿CREATE PROCEDURE [dbo].[upCreateIndexes_RELIGION] AS
	IF EXISTS (SELECT NAME FROM SYSINDEXES WHERE NAME = 'ind_RELIGION')
	DROP INDEX RELIGION.ind_RELIGION

	IF EXISTS (SELECT NAME FROM SYSINDEXES WHERE NAME = 'IX_RELIGION_KEY_RELIGION')
	DROP INDEX RELIGION.IX_RELIGION_KEY_RELIGION

	CREATE INDEX IX_RELIGION_KEY_RELIGION
	ON		RELIGION(KEY_RELIGION)
	WITH		FILLFACTOR = 100
