CREATE TABLE [dbo].[ACTIVE_DIRECTORY_ACCOUNT] (
    [EmployeeId]               VARCHAR (50)  NULL,
    [DisplayName]              VARCHAR (150) NULL,
    [FirstName]                VARCHAR (50)  NULL,
    [MiddleName]               VARCHAR (50)  NULL,
    [LastName]                 VARCHAR (50)  NULL,
    [Description]              VARCHAR (70)  NULL,
    [EMail]                    VARCHAR (250) NULL,
    [LongUserName]             VARCHAR (150) NULL,
    [Title]                    VARCHAR (50)  NULL,
    [DirectorateDesc]          VARCHAR (50)  NULL,
    [BaseDesc]                 VARCHAR (50)  NULL,
    [LoginID]                  VARCHAR (50)  NOT NULL,
    [AudienceDesc]             VARCHAR (50)  NULL,
    [Phone]                    VARCHAR (50)  NULL,
    [Address1]                 VARCHAR (100) NULL,
    [Address2]                 VARCHAR (100) NULL,
    [City]                     VARCHAR (50)  NULL,
    [State]                    VARCHAR (2)   NULL,
    [Zip]                      VARCHAR (10)  NULL,
    [Country]                  VARCHAR (50)  NULL,
    [ADExpiresDate]            DATETIME      NULL,
    [ADLoginDate]              VARCHAR (50)  NULL,
    [distinguishedName]        VARCHAR (255) NULL,
    [Inactive]                 BIT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_Inactive] DEFAULT ((0)) NOT NULL,
    [HomeDirectory]            VARCHAR (150) NULL,
    [HomeDrive]                VARCHAR (50)  NULL,
    [CreatedDate]              DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedDate]              DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_UpdatedDate] DEFAULT (getdate()) NULL,
    [LastReportedDate]         DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_LastReportedDate] DEFAULT (getdate()) NULL,
    [Remarks]                  TEXT          NULL,
    [SignedDate]               DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_SignedDate] DEFAULT ('1/1/1776') NULL,
    [SignedDateBy]             INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_SignedDateBy] DEFAULT ((0)) NULL,
    [SupervisorSignedDate]     DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_SupervisorSignedDate] DEFAULT ('1/1/1776') NULL,
    [SupervisorSignedDateBy]   INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_SupervisorSignedDateBy] DEFAULT ((0)) NULL,
    [LBDate]                   DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_LBDate] DEFAULT ('1/1/1776') NULL,
    [LBDateBy]                 INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_LBDateBy] DEFAULT ((0)) NULL,
    [PSQDate]                  DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_PSQDate] DEFAULT ('1/1/1776') NULL,
    [PSQDateBy]                INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_PSQDateBy] DEFAULT ((0)) NULL,
    [CompletedDate]            DATETIME      CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_CompletedDate] DEFAULT ('1/1/1776') NULL,
    [CompletedDateBy]          INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_CompletedDateBy] DEFAULT ((0)) NULL,
    [ActiveDirectoryAccountId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ServiceAccount]           BIT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_ServiceAccount] DEFAULT ((0)) NULL,
    [ADCreatedDate]            DATETIME      NULL,
    [UpdatedBy]                INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_UpdatedBy] DEFAULT ((0)) NULL,
    [SSN]                      VARCHAR (11)  NULL,
    [ENetStatus]               INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_ENetStatus] DEFAULT ((2)) NULL,
    [IsHidden]                 BIT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_IsHidden] DEFAULT ((0)) NULL,
    [SecurityStatusId]         INT           CONSTRAINT [DF_ACTIVE_DIRECTORY_ACCOUNT_SecurityStatusId] DEFAULT ((0)) NULL,
    [DoDEDI]                   NVARCHAR (10) NULL
);


GO
CREATE CLUSTERED INDEX [IX_ACTIVE_DIRECTORY_ACCOUNT_LastReportedDate]
    ON [dbo].[ACTIVE_DIRECTORY_ACCOUNT]([LastReportedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACTIVE_DIRECTORY_ACCOUNT_EmployeeId]
    ON [dbo].[ACTIVE_DIRECTORY_ACCOUNT]([EmployeeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACTIVE_DIRECTORY_ACCOUNT_LoginId]
    ON [dbo].[ACTIVE_DIRECTORY_ACCOUNT]([LoginID] ASC);


GO
CREATE TRIGGER [dbo].[trENet_ACTIVE_DIRECTORY_ACCOUNT_UpdateADA] 
ON dbo.ACTIVE_DIRECTORY_ACCOUNT
FOR INSERT, UPDATE
AS

--ADA Fields
DECLARE @emp1 varchar(50)
DECLARE @ssn1 varchar(11)
DECLARE @long1 varchar(150)
DECLARE @log1 varchar(50)
DECLARE @dist1 varchar(255)
DECLARE @dod1 nvarchar(10)
DECLARE @stat1 int

--ENET Fields
DECLARE @ssn2 varchar(11)
DECLARE @log2 varchar(50)
DECLARE @dist2 varchar(255)
DECLARE @dod2 nvarchar(10)
DECLARE @enum2 int
DECLARE @npi2 numeric(16,3)

--CIAO Fields
DECLARE @usr3 int
DECLARE @ssn3 varchar(11)
DECLARE @log3 varchar(50)
DECLARE @dod3 nvarchar(10)
DECLARE @enum3 int
DECLARE @npi3 numeric(16,3)

--Calculated Fields
DECLARE @dod nvarchar(10)
DECLARE @usr int
DECLARE @dep bit
DECLARE @psnl bigint
DECLARE @stat int

SELECT 
	@emp1 = EmployeeID,
	@ssn1 = SSN,
	@long1 = LongUserName,
	@log1 = LoginID,
	@dist1 = distinguishedName,
	@dod1 = DoDEDI,
	@stat1 = ENetStatus
FROM inserted AS ADA

--DoDEDI from LongUserName in ARS
IF IsNumeric(@long1) = 0
BEGIN
	IF CHARINDEX('@mil', @long1) > 0 AND LEN(@long1) > 12
	BEGIN
		SET @dod = SUBSTRING(@long1,CHARINDEX('@mil', @long1)-10,10)
	END 
END
ELSE
BEGIN
	SET @dod = REPLACE(@long1,'@mil','')
END

--Find UserId
SET @usr = 0
IF LEN(@emp1) > 1
BEGIN
	SET @usr = CAST(@emp1 AS int)
END
ELSE
BEGIN
	--Lookup based on other values
	SELECT @usr = UserID,
	@stat = CAST(Inactive AS int)
	FROM TECHNICIAN
	WHERE LoginId = @log1
	
	IF @usr = 0
	BEGIN
		--Try DoDEDI
		SELECT @usr = UserID,
		@stat = CAST(Inactive AS int)
		FROM TECHNICIAN
		WHERE LoginId = @dod
	END
END

--ENetStatus
IF @usr = 0
BEGIN
	SET @stat = 2
END

--Find PersonnelId
SET @psnl = 0
SELECT TOP 1 @psnl = PersonnelId
FROM CHECKINOUT.dbo.PERSONNEL
WHERE UserId = @usr
ORDER BY CreatedDate DESC

IF @psnl = 0
BEGIN
	SELECT TOP 1 @psnl = PersonnelId
	FROM CHECKINOUT.dbo.PERSONNEL
	WHERE LoginId = @log1
	ORDER BY CreatedDate DESC
END

--Find Deployed
IF CHARINDEX('Deployed', @dist1) > 0
BEGIN
	SET @dep = 1
END
ELSE
BEGIN
	SET @dep = 0
END

IF @usr > 0
BEGIN
--Load ENET variables
SELECT 
	@ssn2 = TECH.SSN,
	@log2 = TECH.LoginId,
	@dist2 = TECH.DistinguishedName,
	@dod2 = TECH.DoDEDI,
	@enum2 = TECH.EmployeeNumber,
	@npi2 = ISNULL(EXT.NPIKey,0)
FROM TECHNICIAN AS TECH
LEFT JOIN TECHNICIAN_EXTENDED AS EXT
ON TECH.UserId = EXT.UserId
WHERE TECH.UserId = @usr
END

IF @psnl > 0
BEGIN
	SELECT
		@usr3 = UserId,
		@ssn3 = SSN,
		@log3 = LoginId,
		@dod3 = DoDEDI,
		@enum3 = EmployeeNumber,
		@npi3 = NPIKey
	FROM CHECKINOUT.dbo.PERSONNEL
	WHERE PersonnelId = @psnl
END

--Start Updates
--Update ADA
IF @usr = 0
BEGIN
	UPDATE ACTIVE_DIRECTORY_ACCOUNT
	SET ENetStatus = @stat,
	UpdatedBy = 0
	WHERE LoginId = @log1
END
ELSE
BEGIN
	--Other Updates
	IF LEN(@emp1) = 0
	BEGIN
		UPDATE ACTIVE_DIRECTORY_ACCOUNT
		SET EmployeeId = CAST(@usr AS varchar(50)),
		UpdatedBy = 0
		WHERE LoginId = @log1
	END
	PRINT '2'
	--IF LEN(@dod1) = 0 OR @dod1 <> @dod2
	--BEGIN
	--	UPDATE ACTIVE_DIRECTORY_ACCOUNT
	--	SET DoDEDI = @dod2,
	--	UpdatedBy = 0
	--	WHERE EmployeeId = CAST(@usr AS varchar(50))
	--END
	
	--IF LEN(@ssn1) = 0 OR @ssn1 <> @ssn2
	--BEGIN
	--	UPDATE ACTIVE_DIRECTORY_ACCOUNT
	--	SET SSN = @ssn2,
	--	UpdatedBy = 0
	--	WHERE EmployeeId = CAST(@usr AS varchar(50))
	--END
END

--Update ENET
IF @usr > 0
BEGIN
	--IF LEN(@dod1) > 0 AND @dod1 <> @dod2
	--BEGIN
	--	UPDATE TECHNICIAN
	--	SET DoDEDI = @dod1,
	--	UpdatedBy = 0
	--	WHERE UserId = @usr
	--END
	
	PRINT '1'
	
	--IF LEN(@dist1) > 0 AND @dist1 <> @dist2
	--BEGIN
	--	UPDATE TECHNICIAN
	--	SET distinguishedName = @dist1,
	--	UpdatedBy = 0
	--	WHERE UserId = @usr
	--END
END

--Update CIAO
IF @psnl > 0
BEGIN
	--IF LEN(@dod1) > 0 AND @dod1 <> @dod3
	--BEGIN
	--	UPDATE CHECKINOUT.dbo.PERSONNEL
	--	SET DoDEDI = @dod1
	--	WHERE PersonnelId = @psnl
	--END
	PRINT '0'
	--IF LEN(@enum2) > 0 AND @enum2 <> @enum3
	--BEGIN
	--	UPDATE CHECKINOUT.dbo.PERSONNEL
	--	SET EmployeeNumber = @enum2
	--	WHERE PersonnelId = @psnl
	--END
	
	--IF LEN(@npi2) > 0 AND @npi2 <> @npi3
	--BEGIN
	--	UPDATE CHECKINOUT.dbo.PERSONNEL
	--	SET NPIKey = @npi2
	--	WHERE PersonnelId = @psnl
	--END
END

GO
DISABLE TRIGGER [dbo].[trENet_ACTIVE_DIRECTORY_ACCOUNT_UpdateADA]
    ON [dbo].[ACTIVE_DIRECTORY_ACCOUNT];


GO
CREATE TRIGGER [dbo].[trENet_ACTIVE_DIRECTORY_ACCOUNT_UpdateCIAO_LB_PSQ] ON dbo.ACTIVE_DIRECTORY_ACCOUNT
FOR UPDATE
AS

DECLARE @lb bit
DECLARE @lbdate datetime
DECLARE @lbby int
DECLARE @psq bit
DECLARE @psqdate datetime
DECLARE @psqby int
DECLARE @ssn varchar(11)
DECLARE @pers bigint
DECLARE @comp datetime
DECLARE @uby int

DECLARE @plbdate datetime
DECLARE @ppsqdate datetime
--Declare @exists int
--DECLARE @flag bit 
--DECLARE @flag2 bit

IF UPDATE(LBDate)
	BEGIN
		SELECT 
			@lbdate = ADA.LBDate,
			@lbby = ADA.UpdatedBy,
			@ssn = ADA.SSN,
			@plbdate = PERS.LBDate
		FROM inserted AS ADA
		INNER JOIN vwCIAO_PERSONNEL AS PERS
		ON ADA.SSN = PERS.SSN

		IF @lbdate > '1/1/1776' AND @lbdate <> @plbdate
			BEGIN
				UPDATE vwCIAO_PERSONNEL
				SET LBDate = @lbdate,
					LBBy = @lbby,
					LB = 1
				WHERE SSN = @ssn
			END
	END


IF UPDATE(PSQDate)
	BEGIN
		SELECT 
			@psqdate = ADA.PSQDate,
			@psqby = ADA.UpdatedBy,
			@ssn = ADA.SSN,
			@ppsqdate = PERS.PSQDate
		FROM inserted AS ADA
		INNER JOIN vwCIAO_PERSONNEL AS PERS
		ON ADA.SSN = PERS.SSN

		IF @psqdate > '1/1/1776' AND @psqdate <> @ppsqdate
			BEGIN
				UPDATE vwCIAO_PERSONNEL
				SET PSQDate = @psqdate,
					PSQBy = @psqby,
					PSQ = 1
				WHERE SSN = @ssn
			END
	END
/*
	IF UPDATE(CompletedDate)
	BEGIN
		SELECT TOP 1
			@comp = ADA.CompletedDate,
			@uby = ADA.UpdatedBy,
			@pers = PERS.PersonnelId
		FROM inserted AS ADA
		INNER JOIN vwCIAO_PERSONNEL AS PERS
		ON ADA.SSN = PERS.SSN
		ORDER BY PERS.PersonnelId Desc

		IF @comp > '1/1/1776'
			BEGIN
				UPDATE vwCHECKIN_APPLICATION_FLOW
				SET CheckInStatusId = 2,
				UpdatedDate = getdate(),
				UpdatedBy = @uby
				WHERE PersonnelId = @pers
				AND AudienceId = 247
			END
	END


*/

GO
CREATE TRIGGER [dbo].[trENet_Active_Directory_Account_UpdateLB_PSQ] ON dbo.ACTIVE_DIRECTORY_ACCOUNT
FOR UPDATE
AS

DECLARE @lb bit
DECLARE @lbdate datetime
DECLARE @lbby int
DECLARE @psq bit
DECLARE @psqdate datetime
DECLARE @psqby int
DECLARE @log varchar(25)

DECLARE @elbdate datetime
DECLARE @epsqdate datetime
--Declare @exists int
--DECLARE @flag bit 
--DECLARE @flag2 bit
DECLARE @msg varchar(50)

IF UPDATE(LBDate)
	BEGIN
		SELECT 
			@lbdate = ADA.LBDate,
			@lbby = ISNULL(ADA.UpdatedBy,0),
			@log = ADA.LoginId,
			@elbdate = ISNULL(TECH.LBDate, '1/1/1776')
		FROM inserted AS ADA
		INNER JOIN TECHNICIAN AS TECH
		ON TECH.LoginId = ADA.LoginId

--SET @msg = CAST(@elbdate AS varchar(50))

		IF @lbdate > '1/1/1776' AND @lbdate <> @elbdate
			--EXEC dbo.procENET_SendMail_AssetAlert 'Trigger', @msg, 'sean.kern.ctr@med.navy.mil', 
--END

--EXEC dbo.procENET_SendMail_AssetAlert 'Trigger', CAST(@lbdate AS varchar(50)), 'sean.kern.ctr@med.navy.mil', ''
				--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES(@lbdate)

			BEGIN
				UPDATE TECHNICIAN
				SET LBDate = @lbdate,
					LB = @lb,
					LBBy = @lbby
				WHERE LoginId = @log
			END
	END

/*
IF UPDATE(PSQDate)
	BEGIN
		SELECT 
			@psq = 1,	
			@psqdate = ADA.PSQDate,
			@psqby = ISNULL(ADA.UpdatedBy,0),
			@log = ADA.LoginId,
			@epsqdate = ISNULL(TECH.PSQDate, '1/1/1776')
		FROM inserted AS ADA
		INNER JOIN TECHNICIAN AS TECH
		ON TECH.LoginId = ADA.LoginId

		IF (@psqdate > '1/1/1776' AND @psqdate <> @epsqdate) 
			BEGIN
				UPDATE TECHNICIAN
				SET PSQDate = @psqdate,
					PSQ = @psq,
					PSQBy = @psqby
				WHERE LoginId = @log
			END

	END

*/

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Active - 0, Inactive - 1, n/a - 2.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACTIVE_DIRECTORY_ACCOUNT', @level2type = N'COLUMN', @level2name = N'ENetStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Use for deleted/moved accounts', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACTIVE_DIRECTORY_ACCOUNT', @level2type = N'COLUMN', @level2name = N'IsHidden';

