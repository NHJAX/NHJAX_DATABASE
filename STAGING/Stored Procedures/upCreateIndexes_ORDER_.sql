CREATE PROCEDURE [dbo].[upCreateIndexes_ORDER_] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_ORDER_')
		DROP INDEX ORDER_.ind_ORDER_
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER__KEY_ORDER')
		DROP INDEX ORDER_.IX_ORDER__KEY_ORDER
		                                                                
	CREATE UNIQUE INDEX 	IX_ORDER__KEY_ORDER
	ON 			ORDER_(KEY_ORDER)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_PATIENT_IEN')
		DROP INDEX ORDER_.IX_ORDER_PATIENT_IEN
		                                                                
	CREATE INDEX 	IX_ORDER_PATIENT_IEN
	ON 			ORDER_(PATIENT_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_ORDER_TYPE_IEN')
		DROP INDEX ORDER_.IX_ORDER_ORDER_TYPE_IEN
		                                                                
	CREATE  INDEX 	IX_ORDER_ORDER_TYPE_IEN
	ON 			ORDER_(ORDER_TYPE_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_LAB_TEST_IEN')
		DROP INDEX ORDER_.IX_ORDER_LAB_TEST_IEN
		                                                                
	CREATE INDEX 	IX_ORDER_LAB_TEST_IEN
	ON 			ORDER_(LAB_TEST_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_MEDICATION_IEN')
		DROP INDEX ORDER_.IX_ORDER_MEDICATION_IEN
		                                                                
	CREATE INDEX 	IX_ORDER_MEDICATION_IEN
	ON 			ORDER_(MEDICATION_IEN)
	WITH 			FILLFACTOR = 100
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_RADIOLOGY_PROCEDURE_IEN')
		DROP INDEX ORDER_.IX_ORDER_RADIOLOGY_PROCEDURE_IEN
		                                                                
	CREATE INDEX 	IX_ORDER_RADIOLOGY_PROCEDURE_IEN
	ON 			ORDER_(RADIOLOGY_PROCEDURE_IEN)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_ORDER_DATE_TIME')
		DROP INDEX ORDER_.IX_ORDER_ORDER_DATE_TIME
		                                                                
	CREATE INDEX 	IX_ORDER_ORDER_DATE_TIME
	ON 			ORDER_(ORDER_DATE_TIME)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_USER_SIG_DATE_TIME')
		DROP INDEX ORDER_.IX_ORDER_USER_SIG_DATE_TIME
		                                                                
	CREATE CLUSTERED INDEX 	IX_ORDER_USER_SIG_DATE_TIME
	ON 			ORDER_(USER_SIG_DATE_TIME)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_ORDER_ORDERING_HCP_IEN')
		DROP INDEX ORDER_.IX_ORDER_ORDERING_HCP_IEN
		                                                                
	CREATE INDEX 	IX_ORDER_ORDERING_HCP_IEN
	ON 			ORDER_(ORDERING_HCP_IEN)
	WITH 			FILLFACTOR = 100
