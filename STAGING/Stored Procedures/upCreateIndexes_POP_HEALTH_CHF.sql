CREATE PROCEDURE [dbo].[upCreateIndexes_POP_HEALTH_CHF] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_POP_HEALTH_CHF')
		DROP INDEX POP_HEALTH_CHF.ind_POP_HEALTH_CHF
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CHF_EDIPN')
		DROP INDEX POP_HEALTH_CHF.IX_POP_HEALTH_CHF_EDIPN
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_CHF_EDIPN
	ON 			POP_HEALTH_CHF(EDIPN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CHF_FMP')
		DROP INDEX POP_HEALTH_CHF.IX_POP_HEALTH_CHF_FMP
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_CHF_FMP
	ON 			POP_HEALTH_CHF(FMP)
	WITH 			FILLFACTOR = 100

	--IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CHF_FMP_SponsorSSN')
	--	DROP INDEX POP_HEALTH_CHF.IX_POP_HEALTH_CHF_FMP_SponsorSSN
		                                                                
	--CREATE INDEX 	IX_POP_HEALTH_CHF_FMP_SponsorSSN
	--ON 			POP_HEALTH_CHF(FMP,SponsorSSN)
	--WITH 			FILLFACTOR = 100
