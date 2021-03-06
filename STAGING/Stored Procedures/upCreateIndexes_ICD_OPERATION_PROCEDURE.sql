﻿CREATE PROCEDURE [dbo].[upCreateIndexes_ICD_OPERATION_PROCEDURE] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ICD_OPERATION_PROCEDURE')
		DROP INDEX ICD_OPERATION_PROCEDURE.ind_ICD_OPERATION_PROCEDURE
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ICD_OPERATION_PROCEDURE_KEY_ICD_OPERATION_PROCEDURE')
		DROP INDEX ICD_OPERATION_PROCEDURE.IX_ICD_OPERATION_PROCEDURE_KEY_ICD_OPERATION_PROCEDURE
		                                                                
	CREATE INDEX 	IX_ICD_OPERATION_PROCEDURE_KEY_ICD_OPERATION_PROCEDURE
	ON 			ICD_OPERATION_PROCEDURE(KEY_ICD_OPERATION_PROCEDURE)
	WITH 			FILLFACTOR = 100
