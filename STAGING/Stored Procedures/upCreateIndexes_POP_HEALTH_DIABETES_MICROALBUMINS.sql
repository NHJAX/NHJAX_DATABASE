﻿CREATE PROCEDURE [dbo].[upCreateIndexes_POP_HEALTH_DIABETES_MICROALBUMINS] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_POP_HEALTH_DIABETES_MICROALBUMINS')
		DROP INDEX POP_HEALTH_DIABETES_MICROALBUMINS.ind_POP_HEALTH_DIABETES_MICROALBUMINS
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_DIABETES_MICROALBUMINS_EDIPN')
		DROP INDEX POP_HEALTH_DIABETES_MICROALBUMINS.IX_POP_HEALTH_DIABETES_MICROALBUMINS_EDIPN
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_DIABETES_MICROALBUMINS_EDIPN
	ON 			POP_HEALTH_DIABETES_MICROALBUMINS(EDIPN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_DIABETES_MICROALBUMINS_FMP')
		DROP INDEX POP_HEALTH_DIABETES_MICROALBUMINS.IX_POP_HEALTH_DIABETES_MICROALBUMINS_FMP
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_DIABETES_MICROALBUMINS_FMP
	ON 			POP_HEALTH_DIABETES_MICROALBUMINS(FMP)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_DIABETES_MICROALBUMINS_testDate')
		DROP INDEX POP_HEALTH_DIABETES_MICROALBUMINS.IX_POP_HEALTH_DIABETES_MICROALBUMINS_testDate
		                                                                
	CREATE INDEX 	IX_POP_HEALTH_DIABETES_MICROALBUMINS_testDate
	ON 			POP_HEALTH_DIABETES_MICROALBUMINS(testDate)
	WITH 			FILLFACTOR = 100

	--IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_POP_HEALTH_DIABETES_MICROALBUMINS_FMP_SponsorSSN')
	--	DROP INDEX POP_HEALTH_DIABETES_MICROALBUMINS.IX_POP_HEALTH_DIABETES_MICROALBUMINS_FMP_SponsorSSN
		                                                                
	--CREATE INDEX 	IX_POP_HEALTH_DIABETES_MICROALBUMINS_FMP_SponsorSSN
	--ON 			POP_HEALTH_DIABETES_MICROALBUMINS(FMP,SponsorSSN)
	--WITH 			FILLFACTOR = 100
