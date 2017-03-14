CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_SelectActive]
(
	@ball bit,
	@bsvc bit,
	@bcomp bit
)
 AS

--1
IF @bcomp = 0 AND @bsvc = 0 AND @ball = 0
BEGIN
SELECT     
	ADA.ActiveDirectoryAccountId, 
	ADA.DisplayName,
	ADA.LastName,
	ADA.FirstName, 
	ADA.MiddleName, 
	ADA.Description, 
	ADA.DirectorateDesc, 
	ADA.LoginID, 
	ADA.AudienceDesc, 
	ADA.ADExpiresDate, 
	ADA.ADLoginDate, 
	ADA.Inactive, 
	ADA.ADCreatedDate, 
	ADA.Remarks, 
	ADA.SignedDate, 
	ADA.SupervisorSignedDate, 
	ADA.LBDate, 
	ADA.PSQDate, 
	ADA.CompletedDate, 
	ADA.ServiceAccount, 
	TECH.UserId, 
	TECH.SSN,
	TECH.DoDEDI
FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
	LEFT OUTER JOIN TECHNICIAN AS TECH 
	ON ADA.LoginID = TECH.LoginId
WHERE ADA.Inactive = 0
AND ADA.CompletedDate IS NULL
AND ADA.ServiceAccount = 0
END

-- 3
ELSE IF @bcomp = 0 AND @bsvc = 0 AND @ball = 1
BEGIN
	SELECT     
		ADA.ActiveDirectoryAccountId, 
		ADA.DisplayName,
		ADA.LastName,
		ADA.FirstName, 
		ADA.MiddleName, 
		ADA.Description, 
		ADA.DirectorateDesc, 
		ADA.LoginID, 
		ADA.AudienceDesc, 
		ADA.ADExpiresDate, 
		ADA.ADLoginDate, 
		ADA.Inactive, 
		ADA.ADCreatedDate, 
		ADA.Remarks, 
		ADA.SignedDate, 
		ADA.SupervisorSignedDate, 
		ADA.LBDate, 
		ADA.PSQDate, 
		ADA.CompletedDate, 
		ADA.ServiceAccount, 
		TECH.UserId, 
		TECH.SSN,
		TECH.DoDEDI
	FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
		LEFT OUTER JOIN TECHNICIAN AS TECH 
		ON ADA.LoginID = TECH.LoginId
	WHERE ADA.CompletedDate IS NULL
	AND ADA.ServiceAccount = 0
END

-- 4
ELSE IF @bcomp = 0 AND @bsvc = 1 AND @ball = 1
BEGIN
	SELECT     
		ADA.ActiveDirectoryAccountId, 
		ADA.DisplayName,
		ADA.LastName,
		ADA.FirstName, 
		ADA.MiddleName, 
		ADA.Description, 
		ADA.DirectorateDesc, 
		ADA.LoginID, 
		ADA.AudienceDesc, 
		ADA.ADExpiresDate, 
		ADA.ADLoginDate, 
		ADA.Inactive, 
		ADA.ADCreatedDate, 
		ADA.Remarks, 
		ADA.SignedDate, 
		ADA.SupervisorSignedDate, 
		ADA.LBDate, 
		ADA.PSQDate, 
		ADA.CompletedDate, 
		ADA.ServiceAccount, 
		TECH.UserId, 
		TECH.SSN,
		TECH.DoDEDI
	FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
		LEFT OUTER JOIN TECHNICIAN AS TECH 
		ON ADA.LoginID = TECH.LoginId
	WHERE ADA.CompletedDate IS NULL
END

-- 5
ELSE IF @bcomp = 1 AND @bsvc = 0 AND @ball = 1
BEGIN
	SELECT     
		ADA.ActiveDirectoryAccountId, 
		ADA.DisplayName,
		ADA.LastName,
		ADA.FirstName, 
		ADA.MiddleName, 
		ADA.Description, 
		ADA.DirectorateDesc, 
		ADA.LoginID, 
		ADA.AudienceDesc, 
		ADA.ADExpiresDate, 
		ADA.ADLoginDate, 
		ADA.Inactive, 
		ADA.ADCreatedDate, 
		ADA.Remarks, 
		ADA.SignedDate, 
		ADA.SupervisorSignedDate, 
		ADA.LBDate, 
		ADA.PSQDate, 
		ADA.CompletedDate, 
		ADA.ServiceAccount, 
		TECH.UserId, 
		TECH.SSN,
		TECH.DoDEDI
	FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
		LEFT OUTER JOIN TECHNICIAN AS TECH 
		ON ADA.LoginID = TECH.LoginId
	WHERE ADA.ServiceAccount = 0
END

-- 6
ELSE IF @bcomp = 1 AND @bsvc = 1 AND @ball = 0
BEGIN
	SELECT     
		ADA.ActiveDirectoryAccountId, 
		ADA.DisplayName,
		ADA.LastName,
		ADA.FirstName, 
		ADA.MiddleName, 
		ADA.Description, 
		ADA.DirectorateDesc, 
		ADA.LoginID, 
		ADA.AudienceDesc, 
		ADA.ADExpiresDate, 
		ADA.ADLoginDate, 
		ADA.Inactive, 
		ADA.ADCreatedDate, 
		ADA.Remarks, 
		ADA.SignedDate, 
		ADA.SupervisorSignedDate, 
		ADA.LBDate, 
		ADA.PSQDate, 
		ADA.CompletedDate, 
		ADA.ServiceAccount, 
		TECH.UserId, 
		TECH.SSN,
		TECH.DoDEDI
	FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
		LEFT OUTER JOIN TECHNICIAN AS TECH 
		ON ADA.LoginID = TECH.LoginId
	WHERE ADA.Inactive = 0
END

-- 7
ELSE IF @bcomp = 0 AND @bsvc = 1 AND @ball = 0
BEGIN
	SELECT     
		ADA.ActiveDirectoryAccountId, 
		ADA.DisplayName,
		ADA.LastName,
		ADA.FirstName, 
		ADA.MiddleName, 
		ADA.Description, 
		ADA.DirectorateDesc, 
		ADA.LoginID, 
		ADA.AudienceDesc, 
		ADA.ADExpiresDate, 
		ADA.ADLoginDate, 
		ADA.Inactive, 
		ADA.ADCreatedDate, 
		ADA.Remarks, 
		ADA.SignedDate, 
		ADA.SupervisorSignedDate, 
		ADA.LBDate, 
		ADA.PSQDate, 
		ADA.CompletedDate, 
		ADA.ServiceAccount, 
		TECH.UserId, 
		TECH.SSN,
		TECH.DoDEDI
	FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
		LEFT OUTER JOIN TECHNICIAN AS TECH 
		ON ADA.LoginID = TECH.LoginId
	WHERE ADA.Inactive = 0
		AND ADA.CompletedDate IS NULL
END

-- 8
ELSE IF @bcomp = 1 AND @bsvc = 0 AND @ball = 0
BEGIN
	SELECT     
		ADA.ActiveDirectoryAccountId, 
		ADA.DisplayName,
		ADA.LastName,
		ADA.FirstName, 
		ADA.MiddleName, 
		ADA.Description, 
		ADA.DirectorateDesc, 
		ADA.LoginID, 
		ADA.AudienceDesc, 
		ADA.ADExpiresDate, 
		ADA.ADLoginDate, 
		ADA.Inactive, 
		ADA.ADCreatedDate, 
		ADA.Remarks, 
		ADA.SignedDate, 
		ADA.SupervisorSignedDate, 
		ADA.LBDate, 
		ADA.PSQDate, 
		ADA.CompletedDate, 
		ADA.ServiceAccount, 
		TECH.UserId, 
		TECH.SSN,
		TECH.DoDEDI
	FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
		LEFT OUTER JOIN TECHNICIAN AS TECH 
		ON ADA.LoginID = TECH.LoginId
	WHERE ADA.ServiceAccount = 0
		AND ADA.Inactive = 0
END

--All (2)
ELSE
BEGIN
SELECT     
	ADA.ActiveDirectoryAccountId, 
	ADA.DisplayName,
	ADA.LastName,
	ADA.FirstName, 
	ADA.MiddleName, 
	ADA.Description, 
	ADA.DirectorateDesc, 
	ADA.LoginID, 
	ADA.AudienceDesc, 
	ADA.ADExpiresDate, 
	ADA.ADLoginDate, 
	ADA.Inactive, 
	ADA.ADCreatedDate, 
	ADA.Remarks, 
	ADA.SignedDate, 
	ADA.SupervisorSignedDate, 
	ADA.LBDate, 
	ADA.PSQDate, 
	ADA.CompletedDate, 
	ADA.ServiceAccount, 
	TECH.UserId, 
	TECH.SSN,
	TECH.DoDEDI
FROM ACTIVE_DIRECTORY_ACCOUNT AS ADA 
	LEFT OUTER JOIN TECHNICIAN AS TECH 
	ON ADA.LoginID = TECH.LoginId
END


