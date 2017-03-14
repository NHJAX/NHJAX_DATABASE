create PROCEDURE [dbo].[upCreateIndexes_BMI] AS
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ind_BMI')
		DROP INDEX BMI.ind_BMI
                                                                
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_SponsorSSN')
		DROP INDEX BMI.IX_BMI_SponsorSSN
		                                                                
	CREATE INDEX 	IX_BMI_SponsorSSN
	ON 			BMI([Sponsor SSN])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_FullName')
		DROP INDEX BMI.IX_BMI_FullName
		                                                                
	CREATE INDEX 	IX_BMI_FullName
	ON 			BMI([Full Name])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_DOB')
		DROP INDEX BMI.IX_BMI_DOB
		                                                                
	CREATE INDEX 	IX_BMI_DOB
	ON 			BMI([DOB])
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_Multi')
		DROP INDEX BMI.IX_BMI_Multi
		                                                                
	CREATE INDEX 	IX_BMI_Multi
	ON 			BMI([Full Name],[Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100

	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_FullName_SponsorSSN')
		DROP INDEX BMI.IX_BMI_FullName_SponsorSSN
		                                                                
	CREATE INDEX 	IX_BMI_FullName_SponsorSSN
	ON 			BMI([Full Name],[Sponsor SSN])
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_FullName_DOB')
		DROP INDEX BMI.IX_BMI_FullName_DOB
		                                                                
	CREATE INDEX 	IX_BMI_FullName_DOB
	ON 			BMI([Full Name],DOB)
	WITH 			FILLFACTOR = 100
	
	IF EXISTS (SELECT name FROM sysindexes WHERE name = 'IX_BMI_SponsorSSN_DOB')
		DROP INDEX BMI.IX_BMI_SponsorSSN_DOB
		                                                                
	CREATE INDEX 	IX_BMI_SponsorSSN_DOB
	ON 			BMI([Sponsor SSN],DOB)
	WITH 			FILLFACTOR = 100
