create PROCEDURE [dbo].[upCreateIndexes_IMMUNIZATIONS_WEEK4] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_IMMUNIZATIONS_WEEK4')
		DROP INDEX IMMUNIZATIONS_WEEK4.ind_IMMUNIZATIONS_WEEK4
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK4([Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_FullName')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_FullName
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_FullName
	ON 			IMMUNIZATIONS_WEEK4([Full Name])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_DOB
	ON 			IMMUNIZATIONS_WEEK4([DOB])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_Multi')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_Multi
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_Multi
	ON 			IMMUNIZATIONS_WEEK4([Full Name],[Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_FullName_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_FullName_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_FullName_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK4([Full Name],[Sponsor SSN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_FullName_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_FullName_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_FullName_DOB
	ON 			IMMUNIZATIONS_WEEK4([Full Name],DOB)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK4_SponsorSSN_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK4.IX_IMMUNIZATIONS_WEEK4_SponsorSSN_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK4_SponsorSSN_DOB
	ON 			IMMUNIZATIONS_WEEK4([Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100
