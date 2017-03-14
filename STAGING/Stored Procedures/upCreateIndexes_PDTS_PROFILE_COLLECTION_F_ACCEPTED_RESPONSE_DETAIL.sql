﻿CREATE PROCEDURE [dbo].[upCreateIndexes_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL')
		DROP INDEX PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.ind_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_KEY_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DE')
		DROP INDEX PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_KEY_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DE
		                                                                
	CREATE INDEX 	IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_KEY_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DE
	ON 			PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL(KEY_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DE)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_ACCEPTED_DATE_FILLED')
		DROP INDEX PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_ACCEPTED_DATE_FILLED
		                                                                
	CREATE CLUSTERED INDEX 	IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_ACCEPTED_DATE_FILLED
	ON 			PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL(ACCEPTED_DATE_FILLED)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_ACCEPTED_NDC_NUMBER')
		DROP INDEX PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL.IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_ACCEPTED_NDC_NUMBER
		                                                                
	CREATE INDEX 	IX_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL_ACCEPTED_NDC_NUMBER
	ON 			PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL(ACCEPTED_NDC_NUMBER)
	WITH 			FILLFACTOR = 100
