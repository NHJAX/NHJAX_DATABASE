create PROCEDURE [dbo].[upCreateIndexes_IMMUNIZATIONS_WEEK1] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_IMMUNIZATIONS_WEEK1')
		DROP INDEX IMMUNIZATIONS_WEEK1.ind_IMMUNIZATIONS_WEEK1
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK1([Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_FullName')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_FullName
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_FullName
	ON 			IMMUNIZATIONS_WEEK1([Full Name])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_DOB
	ON 			IMMUNIZATIONS_WEEK1([DOB])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_Multi')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_Multi
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_Multi
	ON 			IMMUNIZATIONS_WEEK1([Full Name],[Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_FullName_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_FullName_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_FullName_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK1([Full Name],[Sponsor SSN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_FullName_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_FullName_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_FullName_DOB
	ON 			IMMUNIZATIONS_WEEK1([Full Name],DOB)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK1_SponsorSSN_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK1.IX_IMMUNIZATIONS_WEEK1_SponsorSSN_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK1_SponsorSSN_DOB
	ON 			IMMUNIZATIONS_WEEK1([Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100
