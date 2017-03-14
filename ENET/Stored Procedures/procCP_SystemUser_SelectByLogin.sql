-- =============================================
-- Author:		Robert Evans
-- Create date: 11 March 2014
-- Description:	Gets Data For Clinical Portal SystemUser Object
-- =============================================
CREATE PROCEDURE [dbo].[procCP_SystemUser_SelectByLogin] 
	@ParameterTable dbo.ProcedureParameters READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @UsersLogin varchar(256) = ''
DECLARE @ApplicationSecurityGroupId int = 0

SELECT @UsersLogin = ParameterVarcharValue FROM @ParameterTable WHERE ParameterName = 'UsersLogin'
SELECT @ApplicationSecurityGroupId = ParameterIntegerValue FROM @ParameterTable WHERE ParameterName = 'ApplicationSecurityGroupId'

DECLARE @Users_ENET_Id_Number int = 0

DECLARE @UsersSSN nvarchar(11)

SELECT @UsersSSN = SSN FROM TECHNICIAN WHERE UPPER(LoginId) = UPPER(@UsersLogin)

IF (EXISTS(SELECT SSN FROM vwODS_CHCS_USER WHERE SSN = @UsersSSN))
	BEGIN
		SELECT @Users_ENET_Id_Number = UserId FROM TECHNICIAN WHERE UPPER(LoginId) = UPPER(@UsersLogin)
		--SELECT @Users_ENET_Id_Number = EmployeeId FROM ACTIVE_DIRECTORY_ACCOUNT WHERE UPPER(LoginId) = UPPER(@UsersLogin)
	END
ELSE
	BEGIN
		IF (EXISTS(SELECT ProviderSSN FROM vwODS_PROVIDER WHERE ProviderSSN = @UsersSSN))
			BEGIN
				SELECT @Users_ENET_Id_Number = UserId FROM TECHNICIAN WHERE UPPER(LoginId) = UPPER(@UsersLogin)
				--SELECT @Users_ENET_Id_Number = EmployeeId FROM ACTIVE_DIRECTORY_ACCOUNT WHERE UPPER(LoginId) = UPPER(@UsersLogin)
			END
	END
--SELECT @Users_ENET_Id_Number = EmployeeId FROM ACTIVE_DIRECTORY_ACCOUNT WHERE LoginId = @UsersLogin
-- IF > 0 THEN THE USER IS FOUND IN THE DATABASE
IF @Users_ENET_Id_Number > 0
	BEGIN
		--  GET THE LOGGED IN USERS INFORMATION
		SELECT 'ACTIVE_DIRECTORY_INFO'
			  ,T.[UserId]
			  ,T.[UFName]
			  ,T.[ULName]
			  ,T.[UMName]
			  ,T.[Title]
			  ,T.[EMailAddress]
			  ,T.[Location]
			  ,T.[UPhone]
			  ,T.[Extension]
			  ,T.[Comments]
			  ,T.[RankId]
			  ,T.[AudienceId]
			  ,CONVERT(NVARCHAR(12),T.[DOB],101) as DOB
			  ,T.[Rate]
			  ,T.[Sex]
			  ,CONVERT(NVARCHAR(12),T.[ExpectedEndDate],101) as ExpectedEndDate
			  ,HCS.[HealthcareStatusDesc]
			  ,B.[BaseName]
			  ,T.[DisplayName]
			  ,CONVERT(NVARCHAR(12),T.[CheckInDate],101) as CheckInDate
			  ,T.[DoNotDisplay]
			  ,T.[Supervisor]
			  ,T.[EmployeeNumber]
			  ,T.[CellPhone]
			  ,T.[DoDEDI]
			  ,A.[AudienceDesc]
			  ,R.RankAbbrev
		  FROM [ENET].[dbo].[TECHNICIAN] AS T
		  LEFT JOIN HEALTHCARE_STATUS AS HCS ON HCS.HealthcareStatusId = T.HealthcareStatusId
		  LEFT JOIN BASE AS B ON B.BaseId = T.BaseId
		  LEFT JOIN AUDIENCE AS A ON A.AudienceId = T.AudienceId
		  LEFT JOIN [RANK] AS R ON R.RankId = T.RankId
		WHERE T.[UserId] = @Users_ENET_Id_Number

		SELECT  'APPLICATION_ROLES', ARL.[RoleName]
		FROM aspnet_Roles AS ARL 
			INNER JOIN aspnet_UsersInRoles AS UIR 
			ON ARL.RoleId = UIR.RoleId 
			INNER JOIN aspnet_Users 
			ON UIR.UserId = aspnet_Users.UserId 
			INNER JOIN TECHNICIAN AS TECH
			ON aspnet_Users.UserName = TECH.LoginId AND TECH.UserId = @Users_ENET_Id_Number
		ORDER BY TECH.ULName,TECH.UFName,TECH.UMName

		SELECT	'APPLICATION_GROUP_ROLES', AM.AudienceMemberId, AM.TechnicianId, A.AudienceId, A.AudienceDesc, A.DisplayName
		FROM	AUDIENCE_MEMBER as AM
		INNER JOIN AUDIENCE as A ON A.AudienceId = AM.AudienceId AND A.Inactive = 0 
		WHERE     TechnicianId = @Users_ENET_Id_Number
		AND A.SecurityGroupId = CASE WHEN @ApplicationSecurityGroupId > 0 THEN @ApplicationSecurityGroupId ELSE A.SecurityGroupId END
	END
ELSE --IF <= 0 THEN THE USER IS NOT FOUND IN THE DATABASE
	BEGIN
		SELECT 'NO_DATA'
	END
END
