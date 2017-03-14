CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_UpdateInactiveGT2Yrs]

AS
--20120829 Changed to one year. KSK
--Technician Alternates
DELETE FROM TECHNICIAN_ALTERNATE
Where TechnicianId IN
(
	SELECT UserId
	FROM TECHNICIAN
	WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
	AND Inactive = 0 AND DesignationId NOT IN (4)
)

--Audience Member
DELETE FROM AUDIENCE_MEMBER
Where TechnicianId IN
(
	SELECT UserId
	FROM TECHNICIAN
	WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
	AND Inactive = 0 AND DesignationId NOT IN (4)
)

--Security Roles
DELETE FROM aspnet_UsersInRoles
Where UserId IN
(
	SELECT aspnet_Users.UserId
	FROM aspnet_Users
	INNER JOIN TECHNICIAN
	ON aspnet_Users.LoweredUserName = TECHNICIAN.LoginId
	WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
	AND Inactive = 0 AND DesignationId NOT IN (4)
)

--Audience Alternate
DELETE FROM AUDIENCE_ALTERNATE
Where TechnicianId IN
(
	SELECT UserId
	FROM TECHNICIAN
	WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
	AND Inactive = 0 AND DesignationId NOT IN (4)
)

--Technician Security Level
DELETE FROM TECHNICIAN_SECURITY_LEVEL
Where UserId IN
(
	SELECT UserId
	FROM TECHNICIAN
	WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
	AND Inactive = 0 AND DesignationId NOT IN (4)
)

--Security Membership
DELETE FROM aspnet_Membership
Where Email IN
(
	SELECT EMailAddress
	FROM TECHNICIAN
	WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
	AND Inactive = 0 AND DesignationId NOT IN (4)
)

UPDATE TECHNICIAN
SET Inactive = 1,
UpdatedBy = 0
WHERE DATEDIFF(MONTH,UpdatedDate,Getdate()) > 12
and Inactive = 0 AND DesignationId NOT IN (4)



