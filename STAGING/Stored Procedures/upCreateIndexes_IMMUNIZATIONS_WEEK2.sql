create PROCEDURE [dbo].[upCreateIndexes_IMMUNIZATIONS_WEEK2] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_IMMUNIZATIONS_WEEK2')
		DROP INDEX IMMUNIZATIONS_WEEK2.ind_IMMUNIZATIONS_WEEK2
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK2([Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_FullName')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_FullName
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_FullName
	ON 			IMMUNIZATIONS_WEEK2([Full Name])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_DOB
	ON 			IMMUNIZATIONS_WEEK2([DOB])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_Multi')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_Multi
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_Multi
	ON 			IMMUNIZATIONS_WEEK2([Full Name],[Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_FullName_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_FullName_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_FullName_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK2([Full Name],[Sponsor SSN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_FullName_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_FullName_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_FullName_DOB
	ON 			IMMUNIZATIONS_WEEK2([Full Name],DOB)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK2_SponsorSSN_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK2.IX_IMMUNIZATIONS_WEEK2_SponsorSSN_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK2_SponsorSSN_DOB
	ON 			IMMUNIZATIONS_WEEK2([Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100
