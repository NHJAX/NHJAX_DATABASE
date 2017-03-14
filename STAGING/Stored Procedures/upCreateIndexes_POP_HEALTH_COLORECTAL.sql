CREATE PROCEDURE [dbo].[upCreateIndexes_POP_HEALTH_COLORECTAL] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_POP_HEALTH_COLON')
		DROP INDEX POP_HEALTH_COLON.ind_POP_HEALTH_COLON
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_COLON_EDIPN')
		DROP INDEX POP_HEALTH_COLON.IX_POP_HEALTH_COLON_EDIPN
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_COLON_EDIPN
	ON 			POP_HEALTH_COLON(EDIPN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_COLON_FMP')
		DROP INDEX POP_HEALTH_COLON.IX_POP_HEALTH_COLON_FMP
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_COLON_FMP
	ON 			POP_HEALTH_COLON(FMP)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_COLON_ColonoscopyDate')
		DROP INDEX POP_HEALTH_COLON.IX_POP_HEALTH_COLON_ColonoscopyDate
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_COLON_ColonoscopyDate
	ON 			POP_HEALTH_COLON(ColonoscopyDate)
	WITH 			FILLFACTOR = 100


	--IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_COLON_FMP_SponsorSSN')
	--	DROP INDEX POP_HEALTH_COLON.IX_POP_HEALTH_COLON_FMP_SponsorSSN
		                                                                
	--CREATE CLUSTERED INDEX 	IX_POP_HEALTH_COLON_FMP_SponsorSSN
	--ON 			POP_HEALTH_COLON(FMP,SponsorSSN)
	--WITH 			FILLFACTOR = 100
