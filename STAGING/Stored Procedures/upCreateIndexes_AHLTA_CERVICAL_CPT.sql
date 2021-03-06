﻿CREATE PROCEDURE [dbo].[upCreateIndexes_AHLTA_CERVICAL_CPT] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_AHLTA_CERVICAL_CPT')
		DROP INDEX AHLTA_CERVICAL_CPT.ind_AHLTA_CERVICAL_CPT
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_AHLTA_CERVICAL_CPT_FMP_SPONSOR_SSN')
		DROP INDEX AHLTA_CERVICAL_CPT.IX_AHLTA_CERVICAL_CPT_FMP_SPONSOR_SSN
		                                                                
	CREATE INDEX IX_AHLTA_CERVICAL_CPT_FMP_SPONSOR_SSN
	ON 			AHLTA_CERVICAL_CPT([FMP Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_AHLTA_CERVICAL_CPT_FMP_SponsorSSN')
		DROP INDEX AHLTA_CERVICAL_CPT.IX_AHLTA_CERVICAL_CPT_FMP_SponsorSSN

	CREATE CLUSTERED INDEX IX_AHLTA_CERVICAL_CPT_FMP_SponsorSSN
	ON 			AHLTA_CERVICAL_CPT(FMP,SponsorSSN)
	WITH 			FILLFACTOR = 100
