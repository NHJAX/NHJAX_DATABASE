create PROCEDURE [dbo].[upCreateIndexes_IMMUNIZATIONS_WEEK3] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_IMMUNIZATIONS_WEEK3')
		DROP INDEX IMMUNIZATIONS_WEEK3.ind_IMMUNIZATIONS_WEEK3
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK3([Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_FullName')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_FullName
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_FullName
	ON 			IMMUNIZATIONS_WEEK3([Full Name])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_DOB
	ON 			IMMUNIZATIONS_WEEK3([DOB])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_Multi')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_Multi
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_Multi
	ON 			IMMUNIZATIONS_WEEK3([Full Name],[Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_FullName_SponsorSSN')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_FullName_SponsorSSN
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_FullName_SponsorSSN
	ON 			IMMUNIZATIONS_WEEK3([Full Name],[Sponsor SSN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_FullName_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_FullName_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_FullName_DOB
	ON 			IMMUNIZATIONS_WEEK3([Full Name],DOB)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_IMMUNIZATIONS_WEEK3_SponsorSSN_DOB')
		DROP INDEX IMMUNIZATIONS_WEEK3.IX_IMMUNIZATIONS_WEEK3_SponsorSSN_DOB
		                                                                
	CREATE INDEX 	IX_IMMUNIZATIONS_WEEK3_SponsorSSN_DOB
	ON 			IMMUNIZATIONS_WEEK3([Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100
