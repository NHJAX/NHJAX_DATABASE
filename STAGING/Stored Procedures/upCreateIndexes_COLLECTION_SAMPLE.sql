﻿CREATE PROCEDURE [dbo].[upCreateIndexes_COLLECTION_SAMPLE] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_COLLECTION_SAMPLE')
		DROP INDEX COLLECTION_SAMPLE.ind_COLLECTION_SAMPLE
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_COLLECTION_SAMPLE_KEY_COLLECTION_SAMPLE')
		DROP INDEX COLLECTION_SAMPLE.IX_COLLECTION_SAMPLE_KEY_COLLECTION_SAMPLE
		                                                                
	CREATE INDEX 	IX_COLLECTION_SAMPLE_KEY_COLLECTION_SAMPLE
	ON 			COLLECTION_SAMPLE(KEY_COLLECTION_SAMPLE)
	WITH 			FILLFACTOR = 100
