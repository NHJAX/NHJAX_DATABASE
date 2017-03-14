CREATE PROCEDURE [dbo].[procENET_DM_ADA_Select]
(
	@sess varchar(50) = 'xyz'
)
 AS

SELECT
	SessionKey, 
	DMCreatedDate, 
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
	ADCreatedDate, 
	UpdatedBy, 
	SSN, 
	ENetStatus, 
	IsHidden, 
	SecurityStatusId,
	AlphaName,
	DoDEDI
FROM DM_ADA
WHERE SessionKey = @sess

