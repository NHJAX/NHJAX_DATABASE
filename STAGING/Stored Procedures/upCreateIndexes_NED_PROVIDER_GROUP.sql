﻿CREATE PROCEDURE [dbo].[upCreateIndexes_NED_PROVIDER_GROUP] AS

	IF EXISTS (SELECT NAME FROM SYSINDEXES WHERE NAME = 'ind_NED_PROVIDER_GROUP')
		DROP INDEX NED_PROVIDER_GROUP.ind_NED_PROVIDER_GROUP

	IF EXISTS (SELECT NAME FROM SYSINDEXES WHERE NAME = 'IX_NED_PROVIDER_GROUP_KEY_NED_PROVIDER_GROUP')
		DROP INDEX	NED_PROVIDER_GROUP.IX_NED_PROVIDER_GROUP_KEY_NED_PROVIDER_GROUP
	
	CREATE INDEX IX_NED_PROVIDER_GROUP_KEY_NED_PROVIDER_GROUP
	ON			NED_PROVIDER_GROUP(KEY_NED_PROVIDER_GROUP)
	WITH			FILLFACTOR = 100
