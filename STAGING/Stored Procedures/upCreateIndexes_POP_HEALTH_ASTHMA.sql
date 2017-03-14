CREATE PROCEDURE [dbo].[upCreateIndexes_POP_HEALTH_ASTHMA] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_POP_HEALTH_ASTHMA')
		DROP INDEX POP_HEALTH_ASTHMA.ind_POP_HEALTH_ASTHMA
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_ASTHMA_EDIPN')
		DROP INDEX POP_HEALTH_ASTHMA.IX_POP_HEALTH_ASTHMA_EDIPN
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_ASTHMA_EDIPN
	ON 			POP_HEALTH_ASTHMA(EDIPN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_ASTHMA_FMP')
		DROP INDEX POP_HEALTH_ASTHMA.IX_POP_HEALTH_ASTHMA_FMP
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_ASTHMA_FMP
	ON 			POP_HEALTH_ASTHMA(FMP)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_ASTHMA_CtrlRxDate')
		DROP INDEX POP_HEALTH_ASTHMA.IX_POP_HEALTH_ASTHMA_CtrlRxDate
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_ASTHMA_CtrlRxDate
	ON 			POP_HEALTH_ASTHMA(CtrlRxDate)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_ASTHMA_SteroidRxDate')
		DROP INDEX POP_HEALTH_ASTHMA.IX_POP_HEALTH_ASTHMA_SteroidRxDate
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_ASTHMA_SteroidRxDate
	ON 			POP_HEALTH_ASTHMA(SteroidRxDate)
	WITH 			FILLFACTOR = 100

	--IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_ASTHMA_FMP_EDIPN')
	--	DROP INDEX POP_HEALTH_ASTHMA.IX_POP_HEALTH_ASTHMA_FMP_EDIPN
		                                                                
	--CREATE INDEX 	IX_POP_HEALTH_ASTHMA_FMP_EDIPN
	--ON 			POP_HEALTH_ASTHMA(FMP,EDIPN)
	--WITH 			FILLFACTOR = 100
