create PROCEDURE [dbo].[upCreateIndexes_SMOKING_CESSATION] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_SMOKING_CESSATION')
		DROP INDEX SMOKING_CESSATION.ind_SMOKING_CESSATION
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_SponsorSSN')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_SponsorSSN
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_SponsorSSN
	ON 			SMOKING_CESSATION([Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_FullName')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_FullName
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_FullName
	ON 			SMOKING_CESSATION([Full Name])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_DOB')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_DOB
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_DOB
	ON 			SMOKING_CESSATION([DOB])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_Multi')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_Multi
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_Multi
	ON 			SMOKING_CESSATION([Full Name],[Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_FullName_SponsorSSN')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_FullName_SponsorSSN
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_FullName_SponsorSSN
	ON 			SMOKING_CESSATION([Full Name],[Sponsor SSN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_FullName_DOB')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_FullName_DOB
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_FullName_DOB
	ON 			SMOKING_CESSATION([Full Name],DOB)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_SMOKING_CESSATION_SponsorSSN_DOB')
		DROP INDEX SMOKING_CESSATION.IX_SMOKING_CESSATION_SponsorSSN_DOB
		                                                                
	CREATE INDEX 	IX_SMOKING_CESSATION_SponsorSSN_DOB
	ON 			SMOKING_CESSATION([Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100
