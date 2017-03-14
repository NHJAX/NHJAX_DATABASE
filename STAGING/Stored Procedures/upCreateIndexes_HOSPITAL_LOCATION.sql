﻿CREATE PROCEDURE [dbo].[upCreateIndexes_HOSPITAL_LOCATION] AS
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'ind_HOSPITAL_LOCATION')
		DROP INDEX HOSPITAL_LOCATION.ind_HOSPITAL_LOCATION
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_HOSPITAL_LOCATION_KEY_HOSPITAL_LOCATION')
		DROP INDEX HOSPITAL_LOCATION.IX_HOSPITAL_LOCATION_KEY_HOSPITAL_LOCATION
		
	CREATE INDEX 	IX_HOSPITAL_LOCATION_KEY_HOSPITAL_LOCATION
	ON 			HOSPITAL_LOCATION(KEY_HOSPITAL_LOCATION)
	WITH 			FILLFACTOR = 100
				
	IF EXISTS(SELECT name FROM sysindexes WHERE name = 'IX_HOSPITAL_LOCATION_MEPRS_CODE_IEN')
		DROP INDEX HOSPITAL_LOCATION.IX_HOSPITAL_LOCATION_MEPRS_CODE_IEN				
	CREATE INDEX 	IX_HOSPITAL_LOCATION_MEPRS_CODE_IEN
	ON 			HOSPITAL_LOCATION(MEPRS_CODE_IEN)
	WITH 			FILLFACTOR = 100