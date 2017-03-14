create PROCEDURE [dbo].[procENET_Active_Directory_Account_Select]
(
	@ada bigint
)
 AS

SELECT     
	EmployeeId, 
	DisplayName, 
	FirstName, 
	MiddleName, 
	LastName, 
	[Description], 
	EMail, 
	LongUserName, 
	Title, 
	DirectorateDesc, 
	BaseDesc, 
	LoginID, 
	AudienceDesc, 
	Phone, 
	Address1, 
	Address2, 
	City, 
	[State], 
	Zip, 
	Country, 
	ADExpiresDate, 
	ADLoginDate, 
	distinguishedName, 
	Inactive, 
	HomeDirectory, 
	HomeDrive,
	ADCreatedDate,
	CreatedDate,
	UpdatedDate,
	LastReportedDate,
	Remarks,
	SignedDate,
	SupervisorSignedDate,
	LBDate,
	PSQDate,
	CompletedDate,
	ActiveDirectoryAccountId,
	ServiceAccount,
	UpdatedBy
FROM ACTIVE_DIRECTORY_ACCOUNT
WHERE ActiveDirectoryAccountId = @ada

