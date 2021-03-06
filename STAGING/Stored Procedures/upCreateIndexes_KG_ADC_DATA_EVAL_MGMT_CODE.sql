﻿CREATE PROCEDURE [dbo].[upCreateIndexes_KG_ADC_DATA$EVAL_MGMT_CODE] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_KG_ADC_DATA$EVAL_MGMT_CODE')
		DROP INDEX KG_ADC_DATA$EVAL_MGMT_CODE.ind_KG_ADC_DATA$EVAL_MGMT_CODE
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$EVAL_MGMT_CODE_KEY_KG_ADC_DATA$EVAL_MGMT_CODE')
		DROP INDEX KG_ADC_DATA$EVAL_MGMT_CODE.IX_KG_ADC_DATA$EVAL_MGMT_CODE_KEY_KG_ADC_DATA$EVAL_MGMT_CODE
		                                                                
	CREATE INDEX 	IX_KG_ADC_DATA$EVAL_MGMT_CODE_KEY_KG_ADC_DATA$EVAL_MGMT_CODE
	ON 			KG_ADC_DATA$EVAL_MGMT_CODE(KEY_KG_ADC_DATA$EVAL_MGMT_CODE)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$EVAL_MGMT_CODE_KEY_KG_ADC_DATA')
		DROP INDEX KG_ADC_DATA$EVAL_MGMT_CODE.IX_KG_ADC_DATA$EVAL_MGMT_CODE_KEY_KG_ADC_DATA
		                                                                
	CREATE INDEX 	IX_KG_ADC_DATA$EVAL_MGMT_CODE_KEY_KG_ADC_DATA
	ON 			KG_ADC_DATA$EVAL_MGMT_CODE(KEY_KG_ADC_DATA)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_KG_ADC_DATA$EVAL_MGMT_CODE_EVAL_MGMT_CODE_IEN')
		DROP INDEX KG_ADC_DATA$EVAL_MGMT_CODE.IX_KG_ADC_DATA$EVAL_MGMT_CODE_EVAL_MGMT_CODE_IEN
		                                                                
	CREATE INDEX 	IX_KG_ADC_DATA$EVAL_MGMT_CODE_EVAL_MGMT_CODE_IEN
	ON 			KG_ADC_DATA$EVAL_MGMT_CODE(EVAL_MGMT_CODE_IEN)
	WITH 			FILLFACTOR = 100
