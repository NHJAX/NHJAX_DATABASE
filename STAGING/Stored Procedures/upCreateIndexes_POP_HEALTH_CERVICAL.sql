CREATE PROCEDURE [dbo].[upCreateIndexes_POP_HEALTH_CERVICAL] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_POP_HEALTH_CERVICAL')
		DROP INDEX POP_HEALTH_CERVICAL.ind_POP_HEALTH_CERVICAL
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CERVICAL_EDIPN')
		DROP INDEX POP_HEALTH_CERVICAL.IX_POP_HEALTH_CERVICAL_EDIPN
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_CERVICAL_EDIPN
	ON 			POP_HEALTH_CERVICAL(EDIPN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CERVICAL_FMP')
		DROP INDEX POP_HEALTH_CERVICAL.IX_POP_HEALTH_CERVICAL_FMP
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_CERVICAL_FMP
	ON 			POP_HEALTH_CERVICAL(FMP)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CERVICAL_PapLastExamDate')
		DROP INDEX POP_HEALTH_CERVICAL.IX_POP_HEALTH_CERVICAL_PapLastExamDate
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_CERVICAL_PapLastExamDate
	ON 			POP_HEALTH_CERVICAL([PapLastExamDate])
	WITH 			FILLFACTOR = 100


	--IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_CERVICAL_FMP_SponsorSSN')
	--	DROP INDEX POP_HEALTH_CERVICAL.IX_POP_HEALTH_CERVICAL_FMP_SponsorSSN
		                                                                
	--CREATE CLUSTERED INDEX 	IX_POP_HEALTH_CERVICAL_FMP_SponsorSSN
	--ON 			POP_HEALTH_CERVICAL(FMP,SponsorSSN)
	--WITH 			FILLFACTOR = 100
