﻿CREATE PROCEDURE [dbo].[upCreateIndexes_RADIOLOGY_PROCEDURES] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_RADIOLOGY_PROCEDURES')
		DROP INDEX RADIOLOGY_PROCEDURES.ind_RADIOLOGY_PROCEDURES
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RADIOLOGY_PROCEDURES_KEY_RADIOLOGY_PROCEDURES')
		DROP INDEX RADIOLOGY_PROCEDURES.IX_RADIOLOGY_PROCEDURES_KEY_RADIOLOGY_PROCEDURES
		                                                                
	CREATE INDEX 	IX_RADIOLOGY_PROCEDURES_KEY_RADIOLOGY_PROCEDURES
	ON 			RADIOLOGY_PROCEDURES(KEY_RADIOLOGY_PROCEDURES)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_RADIOLOGY_PROCEDURES_CPT_CODE_IEN')
		DROP INDEX RADIOLOGY_PROCEDURES.IX_RADIOLOGY_PROCEDURES_CPT_CODE_IEN
		                                                                
	CREATE INDEX 	IX_RADIOLOGY_PROCEDURES_CPT_CODE_IEN
	ON 			RADIOLOGY_PROCEDURES(CPT_CODE_IEN)
	WITH 			FILLFACTOR = 100