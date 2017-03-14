CREATE TABLE [dbo].[TECHNICIAN] (
    [UserId]              INT            IDENTITY (0, 1) NOT NULL,
    [UFName]              VARCHAR (50)   NULL,
    [ULName]              VARCHAR (50)   NULL,
    [UMName]              VARCHAR (50)   NULL,
    [Title]               VARCHAR (50)   NULL,
    [EMailAddress]        VARCHAR (250)  NULL,
    [DepartmentId]        INT            CONSTRAINT [DF_TECHNICIAN_DepartmentId] DEFAULT ((0)) NOT NULL,
    [Location]            VARCHAR (100)  NULL,
    [LastFour]            VARCHAR (4)    NULL,
    [UPhone]              VARCHAR (50)   NULL,
    [Extension]           VARCHAR (10)   NULL,
    [Comments]            VARCHAR (8000) NULL,
    [UPager]              VARCHAR (50)   NULL,
    [ComputerName]        VARCHAR (20)   NULL,
    [SecurityLevelId]     INT            CONSTRAINT [DF_TECHNICIAN_SecurityLevelId] DEFAULT ((0)) NOT NULL,
    [AltPhone]            VARCHAR (50)   NULL,
    [LoginId]             NVARCHAR (25)  NOT NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_TECHNICIAN_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           INT            CONSTRAINT [DF_TECHNICIAN_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]         DATETIME       CONSTRAINT [DF_TECHNICIAN_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]           INT            CONSTRAINT [DF_TECHNICIAN_UpdatedBy] DEFAULT ((0)) NULL,
    [Inactive]            BIT            CONSTRAINT [DF_TECHNICIAN_Inactive] DEFAULT ((0)) NOT NULL,
    [Password]            VARCHAR (8000) CONSTRAINT [DF_TECHNICIAN_Password] DEFAULT ('106c52ff0035feed1f3f014847002366dfa193bd3558aa5b1480eb78616f82a3') NULL,
    [SSN]                 VARCHAR (11)   NULL,
    [BilletId]            INT            NULL,
    [RankId]              INT            CONSTRAINT [DF_TECHNICIAN_RankId] DEFAULT ((0)) NULL,
    [AudienceId]          BIGINT         CONSTRAINT [DF_TECHNICIAN_AudienceId] DEFAULT ((0)) NULL,
    [distinguishedName]   VARCHAR (255)  NULL,
    [AutoUpdatedDate]     DATETIME       CONSTRAINT [DF_TECHNICIAN_AutoUpdatedDate] DEFAULT (getdate()) NULL,
    [ServiceAccount]      BIT            CONSTRAINT [DF_TECHNICIAN_ServiceAccount] DEFAULT ((0)) NULL,
    [DOB]                 DATETIME       CONSTRAINT [DF_TECHNICIAN_DOB] DEFAULT ('1/1/1776') NULL,
    [Rate]                VARCHAR (50)   NULL,
    [MedStuYr]            VARCHAR (20)   NULL,
    [OtherStu]            VARCHAR (50)   NULL,
    [EAOS_PRD]            DATETIME       CONSTRAINT [DF_TECHNICIAN_EAOS_PRD] DEFAULT ('1/1/1776') NULL,
    [Sex]                 VARCHAR (1)    NULL,
    [CitizenshipId]       INT            NULL,
    [SourceSystemId]      INT            CONSTRAINT [DF_TECHNICIAN_SourceSystemId] DEFAULT ((0)) NULL,
    [NMCIEMail]           VARCHAR (100)  NULL,
    [Address1]            VARCHAR (100)  NULL,
    [Address2]            VARCHAR (100)  NULL,
    [City]                VARCHAR (50)   NULL,
    [State]               VARCHAR (2)    NULL,
    [Zip]                 VARCHAR (10)   NULL,
    [DesignationId]       INT            NULL,
    [PreviousDutyStation] VARCHAR (50)   NULL,
    [ExpectedEndDate]     DATETIME       CONSTRAINT [DF_TECHNICIAN_ExpectedEndDate] DEFAULT ('1/1/1776') NULL,
    [ContractorCompany]   VARCHAR (50)   NULL,
    [ContractNumber]      VARCHAR (50)   NULL,
    [HealthcareStatusId]  INT            CONSTRAINT [DF_TECHNICIAN_HealthcareStatusId] DEFAULT ((0)) NULL,
    [BaseId]              INT            CONSTRAINT [DF_TECHNICIAN_BaseId] DEFAULT ((0)) NULL,
    [NetworkAccess]       BIT            CONSTRAINT [DF_TECHNICIAN_NetworkAccess] DEFAULT ((1)) NULL,
    [OutlookExchange]     BIT            CONSTRAINT [DF_TECHNICIAN_OutlookExchange] DEFAULT ((1)) NULL,
    [EthnicityId]         INT            CONSTRAINT [DF_TECHNICIAN_EthnicityId] DEFAULT ((0)) NULL,
    [DisplayName]         VARCHAR (150)  NULL,
    [CheckInDate]         DATETIME       CONSTRAINT [DF_TECHNICIAN_CheckInDate] DEFAULT (getdate()) NULL,
    [EffectiveDate]       DATETIME       CONSTRAINT [DF_TECHNICIAN_EffectiveDate] DEFAULT (getdate()) NULL,
    [SortOrder]           INT            CONSTRAINT [DF_TECHNICIAN_DisplayUser] DEFAULT ((1)) NULL,
    [ComponentId]         INT            CONSTRAINT [DF_TECHNICIAN_ComponentId] DEFAULT ((0)) NULL,
    [Suffix]              VARCHAR (6)    NULL,
    [ADExpiresDate]       VARCHAR (50)   NULL,
    [ADLoginDate]         VARCHAR (50)   NULL,
    [ADUpdatedDate]       DATETIME       CONSTRAINT [DF_TECHNICIAN_ADUpdatedDate] DEFAULT ('1/1/1776') NULL,
    [LB]                  BIT            CONSTRAINT [DF_TECHNICIAN_LB] DEFAULT ((0)) NULL,
    [PSQ]                 BIT            CONSTRAINT [DF_TECHNICIAN_PSQ] DEFAULT ((0)) NULL,
    [LBDate]              DATETIME       CONSTRAINT [DF_TECHNICIAN_LBDate] DEFAULT ('1/1/1776') NULL,
    [PSQDate]             DATETIME       CONSTRAINT [DF_TECHNICIAN_PSQDate] DEFAULT ('1/1/1776') NULL,
    [LBBy]                INT            CONSTRAINT [DF_TECHNICIAN_LBBy] DEFAULT ((0)) NULL,
    [PSQBy]               INT            CONSTRAINT [DF_TECHNICIAN_PSQBy] DEFAULT ((0)) NULL,
    [DoNotDisplay]        BIT            CONSTRAINT [DF_TECHNICIAN_DoNotDisplay] DEFAULT ((0)) NULL,
    [Supervisor]          VARCHAR (150)  NULL,
    [IsAIMException]      BIT            CONSTRAINT [DF_TECHNICIAN_IsAIMException] DEFAULT ((0)) NULL,
    [AimVersion]          VARCHAR (50)   NULL,
    [Deployed]            BIT            CONSTRAINT [DF_TECHNICIAN_Deployed] DEFAULT ((0)) NULL,
    [EducationLevelId]    INT            CONSTRAINT [DF_TECHNICIAN_EducationLevelId] DEFAULT ((0)) NULL,
    [Prefix]              VARCHAR (10)   NULL,
    [EmployeeNumber]      INT            NULL,
    [HomePhone]           VARCHAR (50)   NULL,
    [CellPhone]           VARCHAR (50)   NULL,
    [DoDEDI]              NVARCHAR (10)  CONSTRAINT [DF_TECHNICIAN_DoDEDI] DEFAULT ((0)) NULL,
    [BloodTypeId]         INT            CONSTRAINT [DF_TECHNICIAN_BloodTypeId] DEFAULT ((0)) NULL,
    [CountryofBirthId]    INT            NULL,
    CONSTRAINT [PK_TECHNICIAN] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [CK_TECHNICIAN] CHECK (len([SSN])>(0))
);


GO
CREATE NONCLUSTERED INDEX [IX_TECHNICIAN_DOB]
    ON [dbo].[TECHNICIAN]([DOB] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TECHNICIAN_LOGINID]
    ON [dbo].[TECHNICIAN]([LoginId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TECHNICIAN_ServiceAccount]
    ON [dbo].[TECHNICIAN]([ServiceAccount] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TECHNICIAN_SSN]
    ON [dbo].[TECHNICIAN]([SSN] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TECHNICIAN_ULName_UFName]
    ON [dbo].[TECHNICIAN]([UFName] ASC, [ULName] ASC);


GO
create TRIGGER [dbo].[trENet_Technician_InsertCIAOPersonnel] ON dbo.TECHNICIAN
FOR INSERT
AS

DECLARE @usr int
DECLARE @ssn varchar(11)

BEGIN
	SELECT @usr = UserId,
	@ssn = SSN
	FROM inserted
	
	BEGIN
		UPDATE vwCIAO_PERSONNEL
		SET UserId = @usr
		WHERE SSN = @ssn
		AND UserId = 0	
	END
END

GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateAudienceId] ON dbo.TECHNICIAN
FOR UPDATE
AS

DECLARE @dept int
DECLARE @deptnew int
DECLARE @tech int
DECLARE @aud bigint
Declare @exists int
DECLARE @flag bit 
DECLARE @flag2 bit

--If it is not the departmentid changing, then only update if
--audienceid is not set

IF NOT UPDATE(DepartmentId)
	BEGIN
		
		SET @flag = 1
	END
ELSE
	BEGIN
		SET @flag = 0
	END

IF NOT UPDATE(AudienceId)
	BEGIN
		
		SET @flag2 = 1
	END
ELSE
	BEGIN
		SET @flag2 = 0
	END

--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('updated running' + CAST(@flag as varchar(10)))

SELECT @dept = TECH.DepartmentId, @tech = TECH.UserId,
@deptnew = TECHNICIAN.AudienceId
FROM inserted AS TECH
INNER JOIN TECHNICIAN 
ON TECH.UserId = TECHNICIAN.UserId

If @deptnew IS NULL OR @deptnew = 0 OR (@flag = 0 AND @flag2 = 1)
	BEGIN
		SELECT	TOP 1 @aud = AudienceId
		FROM	AUDIENCE
		WHERE	(OldDepartmentId = @dept)
		AND AudienceCategoryId = 3
		SET @exists = @@RowCount


		If @exists = 0 
			BEGIN
				UPDATE TECHNICIAN
				SET AudienceId = 0
				WHERE UserId = @tech
			END
		ELSE
			BEGIN
				UPDATE TECHNICIAN
				SET AudienceId = @aud
				WHERE UserId = @tech
			END
	END

GO
DISABLE TRIGGER [dbo].[trENet_Technician_UpdateAudienceId]
    ON [dbo].[TECHNICIAN];


GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateInactive_Alt] ON [dbo].[TECHNICIAN]
FOR UPDATE
AS

DECLARE @tech int
DECLARE @inac bit
DECLARE @name varchar(150)
DECLARE @balt bit
DECLARE @aid varchar(25)
DECLARE @msg varchar(1500)
DECLARE @sub varchar(1000)
DECLARE @To varchar(2000)
DECLARE @CC varchar(2000)

IF UPDATE(Inactive)
	BEGIN
		
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('updated running' + CAST(@flag as varchar(10)))

		SELECT  @tech = UserId,
				@inac = Inactive
		FROM inserted
		
		IF @inac = 1
			BEGIN	
				DECLARE cur CURSOR FAST_FORWARD FOR
				SELECT 
					TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName, 
					EXT.HasAlt,
					EXT.AltId
				FROM  TECHNICIAN AS TECH 
				INNER JOIN TECHNICIAN_EXTENDED AS EXT
				ON TECH.UserId = EXT.UserId
				WHERE (TECH.UserId = @tech) 
					AND EXT.HasAlt = 1

				OPEN cur

				FETCH NEXT FROM cur INTO @name, @balt, @aid
				IF(@@FETCH_STATUS = 0)
					BEGIN

						WHILE(@@FETCH_STATUS = 0)
						BEGIN

							--Send Mail 
							SET @To = 'usn.jacksonville.navhospjaxfl.list.information-assurance-team@mail.mil;'
							SET @Sub = '*** FOUO ***ENET DEACTIVATION ALERT'
							SET @CC = 'kristopher.s.kern.ctr@mail.mil'
							SET @Msg = 'This user has been assigned an alt token and has been deactivated: '

							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9) 
							SET @Msg = @Msg + @name

							SET @Msg = @Msg + CHAR(13)
							SET @Msg = @Msg + 'Alt ID:'+ CHAR(9) 
							SET @Msg = @Msg + @aid
					
							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'Please review this information for accuracy.  '
							SET @Msg = @Msg + 'If you find any errors in this alert, '
							SET @Msg = @Msg + 'please contact MID at 542-7577 '
							SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'https://nhjax-webapps-01/enet/default.aspx'

							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'This electronic mail and any attachments may '
							SET @Msg = @Msg + 'contain information that is subject to the '
							SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
							SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
							SET @Msg = @Msg + 'Use and disclosure of protected health '
							SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
							SET @Msg = @Msg + 'and must be in compliance with these statutes. '
							SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
							SET @Msg = @Msg + 'please notify the sender and delete the data '
							SET @Msg = @Msg + 'without forwarding it or making any copies.'

							--TESTING ONLY - Display Database Info
							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
							SET @Msg = @Msg + 'User:' + CHAR(9)
							SET @Msg = @Msg + CAST(@tech AS varchar(10))

							EXEC dbo.procENET_SendMail_AssetAlert @sub, @msg, @To, @CC
						
							FETCH NEXT FROM cur INTO @name, @balt, @aid
						END
					END
					CLOSE cur
					DEALLOCATE cur
			END
	END

GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateInactive_Tablet] ON [dbo].[TECHNICIAN]
FOR UPDATE
AS

DECLARE @tech int
DECLARE @inac bit
DECLARE @name varchar(150)
DECLARE @net varchar(100)
DECLARE @ser varchar(50)
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @To varchar(200)
DECLARE @CC varchar(200)

IF UPDATE(Inactive)
	BEGIN
		
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('updated running' + CAST(@flag as varchar(10)))

		SELECT  @tech = UserId,
				@inac = Inactive
		FROM inserted
		
		IF @inac = 1
			BEGIN	
				DECLARE cur CURSOR FAST_FORWARD FOR
				SELECT 
					TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName, 
					AST.NetworkName, 
					AST.SerialNumber
				FROM  TECHNICIAN AS TECH 
					INNER JOIN ASSET_ASSIGNMENT AS ASG 
					ON TECH.UserId = ASG.AssignedTo 
					INNER JOIN ASSET AS AST 
					ON ASG.AssetId = AST.AssetId
				WHERE (TECH.UserId = @tech) 
					AND (AST.AssetSubtypeId IN (3, 4)) 
					AND (AST.DispositionId IN (0, 1, 14, 15, 19, 20)) 
					AND (ASG.PrimaryUser = 1)

				OPEN cur

				FETCH NEXT FROM cur INTO @name, @net, @ser
				IF(@@FETCH_STATUS = 0)
					BEGIN

						WHILE(@@FETCH_STATUS = 0)
						BEGIN

							--Send Mail 
							SET @To = 'anthony.d.wells14.ctr@mail.mil;usn.jacksonville.navhospjaxfl.list.mid-tablet-issue@mail.mil'
							SET @Sub = '*** FOUO ***ENET DEACTIVATION ALERT'
							SET @CC = 'kristopher.s.kern.ctr@mail.mil'
							SET @Msg = 'This user has been assigned a portable asset and has been deactivated: '

							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9) + CHAR(9)
							SET @Msg = @Msg + @name

							SET @Msg = @Msg + CHAR(13)
							SET @Msg = @Msg + 'Network Name:'+ CHAR(9) 
							SET @Msg = @Msg + @net

							SET @Msg = @Msg + CHAR(13)
							SET @Msg = @Msg + 'Serial Number:'+ CHAR(9)
							SET @Msg = @Msg + @ser
				
							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'Please review this information for accuracy.  '
							SET @Msg = @Msg + 'If you find any errors in this alert, '
							SET @Msg = @Msg + 'please contact MID at 542-7577 '
							SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'https://nhjax-webapps-01/enet/default.aspx'

							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + 'This electronic mail and any attachments may '
							SET @Msg = @Msg + 'contain information that is subject to the '
							SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
							SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
							SET @Msg = @Msg + 'Use and disclosure of protected health '
							SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
							SET @Msg = @Msg + 'and must be in compliance with these statutes. '
							SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
							SET @Msg = @Msg + 'please notify the sender and delete the data '
							SET @Msg = @Msg + 'without forwarding it or making any copies.'

							--TESTING ONLY - Display Database Info
							SET @Msg = @Msg + CHAR(13) + CHAR(13)
							SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
							SET @Msg = @Msg + 'User:' + CHAR(9)
							SET @Msg = @Msg + CAST(@tech AS varchar(10))

							EXEC dbo.procENET_SendMail_AssetAlert @sub, @msg, @To, @CC
						
							FETCH NEXT FROM cur INTO @name, @net, @ser
						END
					END
					CLOSE cur
					DEALLOCATE cur
			END
	END

GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateCellPhone] ON dbo.TECHNICIAN
FOR INSERT, UPDATE
AS

DECLARE @phold varchar(50)
DECLARE @phnew varchar(50)
DECLARE @usr int
DECLARE @ph bigint
DECLARE @ph2 bigint
DECLARE @max int
DECLARE @uby int
DECLARE @ext varchar(10)

IF UPDATE (CellPhone)  
BEGIN

SELECT @phnew = CellPhone, 
	@usr = UserId,
	@uby = UpdatedBy,
	@ext = ISNULL(Extension,'')
FROM inserted

SELECT @phold = CellPhone
FROM deleted 

SELECT @ph = PhoneId
FROM PHONE
WHERE PhoneNumber = @phold 
AND UserId = @usr

SELECT @ph2 = PhoneId
FROM PHONE
WHERE PhoneNumber = @phnew 
AND UserId = @usr

IF(LEN(@phnew) > 0)
BEGIN

	IF @ph > 0 
	BEGIN
		UPDATE PHONE
		SET PhoneNumber = @phnew,
		Inactive = 0
		WHERE PhoneId = @ph
	END
	ELSE IF @ph2 > 0
	BEGIN
		UPDATE PHONE
		SET PhoneNumber = @phnew,
		Inactive = 0
		WHERE PhoneId = @ph2
	END
	ELSE
	BEGIN
		SELECT @max = MAX(PreferredContactOrder)
		FROM PHONE
		WHERE UserId = @usr
		
		IF @max IS NULL
		BEGIN
		SET @max = 0
		END

		INSERT INTO PHONE
		(
			UserId,
			PhoneTypeId,
			PhoneNumber,
			CreatedBy,
			UpdatedBy,
			PreferredContactOrder,
			Extension
		) 
		VALUES
		(
			@usr, 
			2,
			@phnew,
			@uby,
			@uby,
			@max + 1,
			@ext
		);
	END
	END
END

GO
CREATE TRIGGER [dbo].[trENet_Technician_InsertStudent] ON dbo.TECHNICIAN
FOR INSERT, UPDATE
AS

DECLARE @usr int
DECLARE @inac bit
DECLARE @desg int
DECLARE @ee datetime
DECLARE @cnt int
DECLARE @id int

BEGIN
	SET @cnt = 0
	SET @id = 0
	
	SELECT @usr = UserId,
		@inac = Inactive,
		@desg = DesignationId,
		@ee = ExpectedEndDate
	FROM inserted
	
	SELECT @id = UserId
	FROM PERSONNEL_TYPE_LIST
	WHERE UserId = @usr AND PersonnelTypeId = 5
	
	IF @id < 1
	BEGIN
		SELECT @id = UserId
		FROM PERSONNEL_TYPE_LIST
		WHERE UserId = @usr AND PersonnelTypeId = 6
	END
	
	BEGIN
	IF (@inac = 0 AND @desg = 6 AND DATEDIFF(DAY,GETDATE(),@ee) <= 30) 
	OR (@id > 0 AND @inac = 0 AND DATEDIFF(DAY,GETDATE(),@ee) <= 30) 
		BEGIN
		
			SELECT  @cnt = COUNT(ExcludeTrainingDept) 
			FROM TECHNICIAN_EXTENDED
			WHERE UserId = @usr
			
			IF (@cnt > 0)
			BEGIN
				UPDATE TECHNICIAN_EXTENDED
				SET ExcludeTrainingDept = 1
				WHERE UserId = @usr
			END	
			ELSE
			BEGIN
				INSERT INTO TECHNICIAN_EXTENDED
				(UserId,ExcludeTrainingDept)
				VALUES
				(@usr,1)
			END
		END
		ELSE
		BEGIN
			IF (@inac = 0 AND @desg = 6)
			BEGIN
				UPDATE TECHNICIAN_EXTENDED
				SET ExcludeTrainingDept = 0
				WHERE UserId = @usr
			END
		END
	END
END

GO
CREATE TRIGGER [dbo].[trENet_TECHNICIAN_Update] ON [dbo].[TECHNICIAN]
FOR UPDATE
AS

DECLARE @usr int
DECLARE @uf varchar(50)
DECLARE @ul varchar(50)
DECLARE @um varchar(50)
DECLARE @titl varchar(50)
DECLARE @email varchar(250)
DECLARE @loc varchar(100)
DECLARE @ph varchar(50)
DECLARE @ext varchar(10)
DECLARE	@com varchar(4000)
DECLARE	@up varchar(50)
DECLARE	@alt varchar(50)
DECLARE	@log nvarchar(25)
DECLARE	@cdate datetime 
DECLARE	@cby int 
DECLARE	@udate datetime
DECLARE	@uby int
DECLARE	@inac bit
DECLARE	@ssn varchar(11)
DECLARE	@bill int
DECLARE	@rnk int 
DECLARE	@aud bigint 
DECLARE	@dist varchar(255)
DECLARE @audate datetime 
DECLARE @svc bit 
DECLARE @dob datetime
DECLARE @rate varchar(15) 
DECLARE @med varchar(20) 
DECLARE @oth varchar(50) 
DECLARE @eaos datetime 
DECLARE @sex varchar(1) 
DECLARE @citz int 
DECLARE @ss int
DECLARE @nmci varchar(100)
DECLARE @add1 varchar(100) 
DECLARE @add2 varchar(100)
DECLARE @cit varchar(50)
DECLARE @st varchar(2)
DECLARE @zip varchar(10)
DECLARE @desg int
DECLARE @prev varchar(50)
DECLARE @eedate datetime
DECLARE @ctr varchar(50)
DECLARE @ctrn varchar(50)
DECLARE @hstat int
DECLARE @bas int
DECLARE @net bit
DECLARE @out bit
DECLARE @eth int
DECLARE @disp varchar(150)
DECLARE @cidate datetime
DECLARE @effdate datetime
DECLARE @so int
DECLARE @comp int
DECLARE @suf varchar(6)
DECLARE @adedate varchar(50)
DECLARE @adldate varchar(50)
DECLARE @adudate datetime
DECLARE @lb bit
DECLARE @psq bit
DECLARE @lbdate datetime
DECLARE @psqdate datetime
DECLARE @lbby int
DECLARE @psqby int
DECLARE @dndisp bit
DECLARE @sup varchar(150)
DECLARE @aimx bit
DECLARE @aimv varchar(50)
DECLARE @dep bit
DECLARE @edu int
DECLARE @pre varchar(10)
DECLARE @empnum int
DECLARE @hph varchar(50)
DECLARE @cph varchar(50)
DECLARE @dod nvarchar(10)
DECLARE @btyp int
DECLARE @cob int
DECLARE	@hby int

--Don't want the generic updates to trigger

IF NOT UPDATE(UpdatedBy) AND NOT UPDATE(UpdatedDate)
BEGIN

	SELECT 
		@usr = UserId, 
		@uf = UFName, 
		@ul = ULName, 
		@um = UMName, 
		@titl = Title, 
		@email = EMailAddress, 
		@loc = Location, 
		@ph = UPhone, 
		@ext = Extension, 
		@com = CAST(Comments AS varchar(4000)), 
		@up = UPager, 
		@alt = AltPhone, 
		@log = LoginId, 
		@cdate = CreatedDate, 
		@cby = CreatedBy, 
		@udate = UpdatedDate, 
		@uby = UpdatedBy, 
		@inac = Inactive, 
		@ssn = SSN, 
		@bill = BilletId, 
		@rnk = RankId, 
		@aud = AudienceId, 
		@dist = distinguishedName, 
        @audate = AutoUpdatedDate, 
        @svc = ServiceAccount, 
        @dob = DOB, 
        @rate = Rate, 
        @med = MedStuYr, 
        @oth = OtherStu, 
        @eaos = EAOS_PRD, 
        @sex = Sex, 
        @citz = CitizenshipId, 
        @ss = SourceSystemId, 
        @nmci = NMCIEMail, 
        @add1 = Address1, 
        @add2 = Address2, 
        @cit = City, 
        @st = [State],
        @zip = Zip, 
        @desg = DesignationId, 
        @prev = PreviousDutyStation, 
        @eedate = ExpectedEndDate, 
        @ctr = ContractorCompany, 
        @ctrn = ContractNumber, 
        @hstat = HealthcareStatusId, 
        @bas = BaseId, 
        @net = NetworkAccess, 
        @out = OutlookExchange, 
        @eth = EthnicityId, 
        @disp = DisplayName, 
        @cidate = CheckInDate, 
        @effdate = EffectiveDate, 
        @so = SortOrder, 
        @comp = ComponentId, 
        @suf = Suffix, 
        @adedate = ADExpiresDate, 
        @adldate = ADLoginDate, 
        @adudate = ADUpdatedDate, 
        @lb = LB, 
        @psq = PSQ, 
        @lbdate = LBDate, 
        @psqdate = PSQDate, 
        @lbby = LBBy, 
        @psqby = PSQBy, 
        @dndisp = DoNotDisplay, 
        @sup = Supervisor, 
        @aimx = IsAIMException, 
        @aimv = AimVersion, 
        @dep = Deployed, 
        @edu = EducationLevelId, 
        @pre = Prefix, 
@empnum = EmployeeNumber, 
        @hph = HomePhone, 
        @cph = CellPhone, 
        @dod = DoDEDI, 
        @btyp = BloodTypeId, 
        @cob = CountryofBirthId,
		@hby = UpdatedBy

	FROM deleted 

		BEGIN
		INSERT INTO TECHNICIAN_HISTORY
		(
			UserId, 
			UFName, 
			ULName, 
			UMName, 
			Title, 
			EMailAddress, 
			Location, 
			UPhone, 
			Extension, 
			Comments, 
			UPager, 
			AltPhone, 
			LoginId, 
			CreatedDate, 
            CreatedBy, 
            UpdatedDate, 
            UpdatedBy, 
            Inactive, 
            SSN, 
            BilletId, 
            RankId, 
            AudienceId, 
            distinguishedName, 
            AutoUpdatedDate, 
            ServiceAccount, 
            DOB, 
            Rate, 
            MedStuYr, 
            OtherStu, 
            EAOS_PRD, 
            Sex, 
            CitizenshipId, 
            SourceSystemId, 
            NMCIEMail, 
            Address1, 
            Address2, 
            City, 
            [State], 
            Zip, 
            DesignationId, 
            PreviousDutyStation, 
            ExpectedEndDate, 
            ContractorCompany, 
            ContractNumber, 
            HealthcareStatusId, 
            BaseId, 
            NetworkAccess, 
            OutlookExchange, 
            EthnicityId, 
            DisplayName, 
            CheckInDate, 
            EffectiveDate, 
            SortOrder, 
            ComponentId, 
            Suffix, 
            ADExpiresDate, 
            ADLoginDate, 
            ADUpdatedDate, 
            LB, 
            PSQ, 
            LBDate, 
            PSQDate, 
            LBBy, 
            PSQBy, 
            DoNotDisplay, 
            Supervisor, 
            IsAimExcetpion, 
            AIMVersion, 
            Deployed, 
            EducationLevelId, 
            Prefix, 
            EmployeeNumber, 
            HomePhone, 
            CellPhone, 
            DoDEDI, 
            BloodTypeId, 
            CountryofBirthId, 
            HistoryBy
		)
		VALUES     
		(
			@usr, 
			@uf, 
			@ul, 
			@um, 
			@titl, 
			@email, 
			@loc, 
			@ph, 
			@ext, 
			@com, 
			@up, 
			@alt, 
			@log, 
			@cdate, 
			@cby, 
			@udate, 
			@uby, 
			@inac, 
			@ssn, 
			@bill, 
			@rnk, 
			@aud, 
			@dist, 
			@audate, 
			@svc, 
			@dob, 
			@rate, 
			@med, 
			@oth, 
			@eaos, 
			@sex, 
			@citz, 
			@ss, 
			@nmci, 
			@add1, 
			@add2, 
			@cit, 
			@st,
			@zip, 
			@desg, 
			@prev, 
			@eedate, 
			@ctr, 
			@ctrn, 
			@hstat, 
			@bas, 
			@net, 
			@out, 
			@eth, 
			@disp, 
			@cidate, 
			@effdate, 
			@so, 
			@comp, 
			@suf, 
			@adedate, 
			@adldate, 
			@adudate, 
			@lb, 
			@psq, 
			@lbdate, 
			@psqdate, 
			@lbby, 
			@psqby, 
			@dndisp, 
			@sup, 
			@aimx, 
			@aimv, 
			@dep, 
			@edu, 
			@pre, 
			@empnum, 
			@hph, 
			@cph, 
			@dod, 
			@btyp, 
			@cob,
			@hby
		)
		END

END

GO
CREATE TRIGGER [dbo].[ENET_Technician_Relocation]
   ON  [dbo].[TECHNICIAN]
   FOR UPDATE
AS 

DECLARE @usr int
DECLARE @l4nm varchar(54)
DECLARE @eff varchar(12)
DECLARE @supe varchar(150)
DECLARE @audold varchar(50)
DECLARE @audnew varchar(50)
DECLARE @codeold varchar(20)
DECLARE @codenew varchar(20)
DECLARE @phold varchar(50)
DECLARE @phnew varchar(50)
DECLARE @dirold varchar(50)
DECLARE @dirnew varchar(50)
DECLARE @uby varchar(54)
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @To varchar(2000)
DECLARE @CC varchar(200)
DECLARE @mail varchar(101)
DECLARE @ss int


IF UPDATE(AudienceId) OR UPDATE(UPhone)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT
	@usr = TECH.UserId, 
	@l4nm = TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName + ' ' + ISNULL(RIGHT(TECH.SSN,4),'XXXX'), 
	@audnew = AUD.DisplayName,
	@codenew = ISNULL(AUD.OrgChartCode,'UNK'),
	@phnew = TECH.UPhone,
	@dirnew = ISNULL(DIR.DisplayName, 'Unknown'),
	@uby = UBY.ULName + ', ' + UBY.UFName,
	@eff = CAST(ISNULL(TECH.EffectiveDate, CAST('1/1/1776' AS DateTime)) AS varchar(12)),
	@supe = ISNULL(TECH.Supervisor, ' '),
	@ss = TECH.SourceSystemId
FROM AUDIENCE AS AUD 
	INNER JOIN inserted AS TECH 
	INNER JOIN TECHNICIAN AS UBY 
	ON TECH.UpdatedBy = UBY.UserId 
	ON AUD.AudienceId = TECH.AudienceId 
	LEFT OUTER JOIN AUDIENCE AS DIR 
	INNER JOIN vwENET_AUDIENCE_DIRECTORATE AS ADIR 
	ON DIR.AudienceId = ADIR.DirectorateId 
	ON TECH.AudienceId = ADIR.AudienceId


SELECT @audold = AUD.DisplayName,
	@codeold = ISNULL(AUD.OrgChartCode,'UNK'),
	@phold = ISNULL(TECH.UPhone, ' '),
	@dirold = DIR.DisplayName
FROM AUDIENCE AS DIR 
	INNER JOIN vwENET_Audience_Directorate AS ADIR 
	ON DIR.AudienceId = ADIR.DirectorateId 
	INNER JOIN deleted AS TECH 
	INNER JOIN AUDIENCE AS AUD 
	ON TECH.AudienceId = AUD.AudienceId		
	ON ADIR.AudienceId = TECH.AudienceId

--Extract Mail List
DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT     
	TECH.EMailAddress
	FROM	AUDIENCE_MEMBER AS MEM 
		INNER JOIN TECHNICIAN AS TECH 
		ON MEM.TechnicianId = TECH.UserId
	WHERE	(MEM.AudienceId = 303) 
		AND (LEN(TECH.EMailAddress) > 0)

OPEN cur
FETCH NEXT FROM cur INTO @mail

	if(@@FETCH_STATUS = 0)
	
	BEGIN
	SET @To = ''
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @To = @To + @mail + ';'
			FETCH NEXT FROM cur INTO @mail
		END
	END
CLOSE cur
DEALLOCATE cur

IF LEN(@To) = 0
	BEGIN
		SET @To = 'kristopher.s.kern.ctr@mail.mil'
	END
		
		SET @Sub = '*** FOUO ***ENET PERSONNEL UPDATE'
		SET @CC = ''
		SET @Msg = 'The following update has occurred: '

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @l4nm


If @audnew <> @audold
	BEGIN		
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'OLD DEPT:'+ CHAR(9) 
		SET @Msg = @Msg + @audold
		SET @Msg = @Msg + ' (' + @codeold + ')'

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'NEW DEPT:'+ CHAR(9)
		SET @Msg = @Msg + @audnew
		SET @Msg = @Msg + ' (' + @codenew + ')'

		If @dirnew <> @dirold
			BEGIN
				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'OLD DIR:'+ CHAR(9) 
				SET @Msg = @Msg + @dirold
				
				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'NEW DIR:'+ CHAR(9)
				SET @Msg = @Msg + @dirnew
			END
		Else
			BEGIN
				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'DIR:'+ CHAR(9) + CHAR(9)
				SET @Msg = @Msg + @dirnew
			END
	END

If @phnew <> @phold
	BEGIN
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'OLD PHONE:'+ CHAR(9) 
		SET @Msg = @Msg + @phold
		
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'NEW PHONE:'+ CHAR(9)
		SET @Msg = @Msg + @phnew
	END

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'BY:'+ CHAR(9) + CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @uby

		SET @Msg = @Msg + CHAR(13) 
		SET @Msg = @Msg + 'EFFECTIVE DATE:'+ CHAR(9) 
		SET @Msg = @Msg + @eff

		SET @Msg = @Msg + CHAR(13) 
		SET @Msg = @Msg + 'SUPERVISOR:'+ CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @supe
		
		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'Please review this information for accuracy.  '
		SET @Msg = @Msg + 'If you find any errors in this alert, '
		SET @Msg = @Msg + 'please contact MID at 542-7577 '
		SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'https://nhjax-webapps-01/enet/default.aspx'

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'This electronic mail and any attachments may '
		SET @Msg = @Msg + 'contain information that is subject to the '
		SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
		SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
		SET @Msg = @Msg + 'Use and disclosure of protected health '
		SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
		SET @Msg = @Msg + 'and must be in compliance with these statutes. '
		SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
		SET @Msg = @Msg + 'please notify the sender and delete the data '
		SET @Msg = @Msg + 'without forwarding it or making any copies.'

		--TESTING ONLY - Display Database Info
		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
		SET @Msg = @Msg + 'User:' + CHAR(9) + CHAR(9)
		SET @Msg = @Msg + CAST(@usr	AS varchar(10)) + CHAR(13)
		SET @Msg = @Msg + 'Source:' + CHAR(9)
		SET @Msg = @Msg + CAST(@ss AS varchar(3))

IF @audnew <> @audold OR @phnew <> @phold
	BEGIN
		EXEC dbo.procENET_SendMail_TechnicianUpdate @sub, @msg, @To, @CC
	END

END

GO
CREATE TRIGGER [dbo].[ENET_Technician_Site_Deactivation]
   ON  [dbo].[TECHNICIAN]
   FOR UPDATE
AS 

DECLARE @usr int
DECLARE @l4nm varchar(54)
DECLARE @uby varchar(54)
DECLARE @msg varchar(1500)
DECLARE @sub varchar(1000)
DECLARE @To varchar(2000)
DECLARE @CC varchar(2000)
DECLARE @mail varchar(1010)
DECLARE @site varchar(1000)
DECLARE @url nvarchar(1000)
DECLARE @sites varchar(4000)
DECLARE @inac bit

IF UPDATE(Inactive)
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
	SELECT
		@usr = TECH.UserId, 
		@l4nm = TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName + ' ' + ISNULL(RIGHT(TECH.SSN,4),'XXXX'), 
		@uby = UBY.ULName + ', ' + UBY.UFName,
		@inac = TECH.Inactive
	FROM inserted AS TECH 
		INNER JOIN TECHNICIAN AS UBY 
		ON TECH.UpdatedBy = UBY.UserId 
	
	IF @inac = 1
	BEGIN	
		--Extract website list
		DECLARE curSite CURSOR FAST_FORWARD FOR
			SELECT DISTINCT 
			RA.Title, ISNULL(RTRIM(LTRIM(RA.ScopeURL)),' ') AS Url
			FROM TECHNICIAN  AS TECH
				INNER JOIN vwSPDB_Role_Assignments AS RA
				--INNER JOIN vwINTRA_SITE_CatDef AS CatDef
				ON TECH.EMailAddress 
				--COLLATE Latin1_General_CI_AS_KS_WS = CatDef.Contact1Email
				COLLATE SQL_Latin1_General_CP1_CI_AS = RA.tp_Email
			WHERE TECH.UserId = @usr
			AND DataLength(TECH.EMailAddress) > 0

		OPEN curSite
		FETCH NEXT FROM curSite INTO @site, @url
			if(@@FETCH_STATUS = 0)
			BEGIN
			SET @sites = ''
				WHILE(@@FETCH_STATUS = 0)
				BEGIN
					SET @sites = @sites + @site + ': ' + @url + CHAR(13)
					FETCH NEXT FROM curSite INTO @site, @url
				END
			END
		CLOSE curSite
		DEALLOCATE curSite

		--Extract Mail List
		DECLARE cur CURSOR FAST_FORWARD FOR
			SELECT     
			TECH.EMailAddress
			FROM	AUDIENCE_MEMBER AS MEM 
				INNER JOIN TECHNICIAN AS TECH 
				ON MEM.TechnicianId = TECH.UserId
			WHERE	(MEM.AudienceId = 339) 
				AND (DataLength(TECH.EMailAddress) > 0)

		OPEN cur
		FETCH NEXT FROM cur INTO @mail

			if(@@FETCH_STATUS = 0)
			
			BEGIN
			SET @To = ''
				WHILE(@@FETCH_STATUS = 0)
				BEGIN
					SET @To = @To + @mail + ';'
					FETCH NEXT FROM cur INTO @mail
				END
			END
		CLOSE cur
		DEALLOCATE cur

		IF DataLength(@To) = 0
			BEGIN
				SET @To = 'kristopher.s.kern.ctr@mail.mil'
			END
				
			SET @Sub = '*** FOUO ***ENET PERSONNEL UPDATE - SHAREPOINT'
			SET @CC = ''
			SET @Msg = 'The following user has elevated permissions in SharePoint has been deactivated: '

			SET @Msg = @Msg + CHAR(13) + CHAR(13)
			SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9)
			SET @Msg = @Msg + @l4nm


		If DataLength(@sites) > 0
			BEGIN		
				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Content Areas:'+ CHAR(13) 
				SET @Msg = @Msg + @sites
			
				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'BY:'+ CHAR(9) + CHAR(9) + CHAR(9)
				SET @Msg = @Msg + @uby

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'Please review this information for accuracy.  '
				SET @Msg = @Msg + 'If you find any errors in this alert, '
				SET @Msg = @Msg + 'please contact MID at 542-7577 '
				SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'https://nhjax-webapps-01/enet/default.aspx'

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'This electronic mail and any attachments may '
				SET @Msg = @Msg + 'contain information that is subject to the '
				SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
				SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
				SET @Msg = @Msg + 'Use and disclosure of protected health '
				SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
				SET @Msg = @Msg + 'and must be in compliance with these statutes. '
				SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
				SET @Msg = @Msg + 'please notify the sender and delete the data '
				SET @Msg = @Msg + 'without forwarding it or making any copies.'

				--TESTING ONLY - Display Database Info
				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
				SET @Msg = @Msg + 'User:' + CHAR(9)
				SET @Msg = @Msg + CAST(@usr	AS varchar(10))

				EXEC dbo.procENET_SendMail_TechnicianUpdate @sub, @msg, @To, @CC
			END
		END
	END

GO
DISABLE TRIGGER [dbo].[ENET_Technician_Site_Deactivation]
    ON [dbo].[TECHNICIAN];


GO
CREATE TRIGGER [dbo].[trENet_Technician_InsertAudienceId] ON dbo.TECHNICIAN
FOR INSERT
AS

DECLARE @dept int
DECLARE @deptnew int
DECLARE @tech int
DECLARE @aud bigint
Declare @exists int
DECLARE @flag bit 

--only run this update if it is department that is updated
IF NOT UPDATE(DepartmentId)
	BEGIN
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('not updated')
		SET @flag = 1
	END
ELSE
	BEGIN
		SET @flag = 0
	END

--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('inserted running' + CAST(@flag as varchar(10)))

IF @flag = 0 
BEGIN
	SELECT @dept = TECH.DepartmentId, @tech = TECH.UserId,
	@deptnew = ISNULL(TECH.AudienceId,0)
	FROM inserted AS TECH
	
	IF @deptnew = 0
		BEGIN
			SELECT	TOP 1 @aud = AudienceId
			FROM	AUDIENCE
			WHERE	(OldDepartmentId = @dept)
			AND AudienceCategoryId = 3
			SET @exists = @@RowCount


			If @exists = 0 
				BEGIN
					UPDATE TECHNICIAN
					SET AudienceId = 0
					WHERE UserId = @tech
				END
			ELSE
				BEGIN
					UPDATE TECHNICIAN
					SET AudienceId = @aud
					WHERE UserId = @tech
				END
		END
END

GO
DISABLE TRIGGER [dbo].[trENet_Technician_InsertAudienceId]
    ON [dbo].[TECHNICIAN];


GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateLB_PSQ] ON dbo.TECHNICIAN
FOR UPDATE
AS

DECLARE @lb bit
DECLARE @lbdate datetime
DECLARE @lbby int
DECLARE @psq bit
DECLARE @psqdate datetime
DECLARE @psqby int
DECLARE @log varchar(25)

DECLARE @albdate datetime
DECLARE @apsqdate datetime
--Declare @exists int
--DECLARE @flag bit 
--DECLARE @flag2 bit

IF UPDATE(LBDate)
	BEGIN
		SELECT 
			@lb = TECH.LB,	
			@lbdate = TECH.LBDate,
			@lbby = TECH.LBBy,
			@log = TECH.LoginId,
			@albdate = ADA.LBDate
		FROM inserted AS TECH
		INNER JOIN ACTIVE_DIRECTORY_ACCOUNT AS ADA
		ON TECH.LoginId = ADA.LoginId

		IF @lbdate > '1/1/1776' AND @lbdate <> @albdate
			BEGIN
				UPDATE ACTIVE_DIRECTORY_ACCOUNT
				SET LBDate = @lbdate,
					UpdatedBy = @lbby,
					UpdatedDate = getdate()
				WHERE LoginId = @log
			END
	END


IF UPDATE(PSQDate)
	BEGIN
		SELECT 
			@psq = TECH.PSQ,	
			@psqdate = TECH.PSQDate,
			@psqby = TECH.PSQBy,
			@log = TECH.LoginId,
			@apsqdate = ADA.PSQDate
		FROM inserted AS TECH
		INNER JOIN ACTIVE_DIRECTORY_ACCOUNT AS ADA
		ON TECH.LoginId = ADA.LoginId

		IF @psqdate > '1/1/1776' AND @psqdate <> @psqdate
			BEGIN
				UPDATE ACTIVE_DIRECTORY_ACCOUNT
				SET PSQDate = @psqdate,
					UpdatedBy = @psqby,
					UpdatedDate = getdate()
				WHERE LoginId = @log
			END
	END

GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateWorkPhone] ON dbo.TECHNICIAN
FOR INSERT, UPDATE
AS

DECLARE @phold varchar(50)
DECLARE @phnew varchar(50)
DECLARE @usr int
DECLARE @ph bigint
DECLARE @ph2 bigint
DECLARE @max int
DECLARE @uby int
DECLARE @ext varchar(10)

IF UPDATE (UPhone) OR UPDATE (Extension) 
BEGIN

SELECT @phnew = UPhone, 
	@usr = UserId,
	@uby = UpdatedBy,
	@ext = Extension
FROM inserted

SELECT @phold = UPhone
FROM deleted 

SELECT @ph = PhoneId
FROM PHONE
WHERE PhoneNumber = @phold 
AND UserId = @usr

SELECT @ph2 = PhoneId
FROM PHONE
WHERE PhoneNumber = @phnew 
AND UserId = @usr

IF(LEN(@phnew) > 0)
BEGIN
	IF @ph > 0
	BEGIN
	UPDATE PHONE
	SET PhoneNumber = @phnew,
	Inactive = 0
	WHERE PhoneId = @ph
	END
	ELSE IF @ph2 > 0
	BEGIN
		UPDATE PHONE
		SET PhoneNumber = @phnew,
		Inactive = 0
		WHERE PhoneId = @ph2
	END
	ELSE
	BEGIN
		SELECT @max = MAX(PreferredContactOrder)
		FROM PHONE
		WHERE UserId = @usr
		
		IF @max IS NULL
		BEGIN
		SET @max = 0
		END

		INSERT INTO PHONE
		(
			UserId,
			PhoneTypeId,
			PhoneNumber,
			CreatedBy,
			UpdatedBy,
			PreferredContactOrder,
			Extension
		) 
		VALUES
		(
			@usr, 
			3,
			@phnew,
			@uby,
			@uby,
			@max + 1,
			@ext
		);
	END
END
END

GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateAltPhone] ON dbo.TECHNICIAN
FOR INSERT, UPDATE
AS

DECLARE @phold varchar(50)
DECLARE @phnew varchar(50)
DECLARE @usr int
DECLARE @ph bigint
DECLARE @ph2 bigint
DECLARE @max int
DECLARE @uby int
DECLARE @ext varchar(10)

IF UPDATE (AltPhone)  
BEGIN

SELECT @phnew = AltPhone, 
	@usr = UserId,
	@uby = UpdatedBy,
	@ext = Extension
FROM inserted

SELECT @phold = AltPhone
FROM deleted 

SELECT @ph = PhoneId
FROM PHONE
WHERE PhoneNumber = @phold 
AND UserId = @usr

SELECT @ph2 = PhoneId
FROM PHONE
WHERE PhoneNumber = @phnew 
AND UserId = @usr

IF(LEN(@phnew) > 0)
BEGIN

	IF @ph > 0
	BEGIN
		UPDATE PHONE
		SET PhoneNumber = @phnew,
		Inactive = 0
		WHERE PhoneId = @ph
	END
	ELSE IF @ph2 > 0
	BEGIN
		UPDATE PHONE
		SET PhoneNumber = @phnew,
		Inactive = 0
		WHERE PhoneId = @ph2
	END
	ELSE
	BEGIN
		SELECT @max = MAX(PreferredContactOrder)
		FROM PHONE
		WHERE UserId = @usr
		
		IF @max IS NULL
		BEGIN
		SET @max = 0
		END

		INSERT INTO PHONE
		(
			UserId,
			PhoneTypeId,
			PhoneNumber,
			CreatedBy,
			UpdatedBy,
			PreferredContactOrder,
			Extension
		) 
		VALUES
		(
			@usr, 
			8,
			@phnew,
			@uby,
			@uby,
			@max + 1,
			@ext
		);
	END
END
END

GO
CREATE TRIGGER [dbo].[trENet_Technician_UpdateHomePhone] ON dbo.TECHNICIAN
FOR INSERT, UPDATE
AS

DECLARE @phold varchar(50)
DECLARE @phnew varchar(50)
DECLARE @usr int
DECLARE @ph bigint
DECLARE @ph2 bigint
DECLARE @max int
DECLARE @uby int
DECLARE @ext varchar(10)

IF UPDATE (HomePhone)  
BEGIN

SELECT @phnew = HomePhone, 
	@usr = UserId,
	@uby = UpdatedBy,
	@ext = Extension
FROM inserted

SELECT @phold = HomePhone
FROM deleted 

SELECT @ph = PhoneId
FROM PHONE
WHERE PhoneNumber = @phold 
AND UserId = @usr

SELECT @ph2 = PhoneId
FROM PHONE
WHERE PhoneNumber = @phnew 
AND UserId = @usr

IF(LEN(@phnew) > 0)
BEGIN

	IF @ph > 0
	BEGIN
	UPDATE PHONE
	SET PhoneNumber = @phnew,
	Inactive = 0
	WHERE PhoneId = @ph
	END
	ELSE IF @ph2 > 0
	BEGIN
		UPDATE PHONE
		SET PhoneNumber = @phnew,
		Inactive = 0
		WHERE PhoneId = @ph2
	END
	ELSE
	BEGIN
		SELECT @max = MAX(PreferredContactOrder)
		FROM PHONE
		WHERE UserId = @usr
		
		IF @max IS NULL
		BEGIN
		SET @max = 0
		END

		INSERT INTO PHONE
		(
			UserId,
			PhoneTypeId,
			PhoneNumber,
			CreatedBy,
			UpdatedBy,
			PreferredContactOrder,
			Extension
		) 
		VALUES
		(
			@usr, 
			1,
			@phnew,
			@uby,
			@uby,
			@max + 1,
			@ext
		);
	END
END
END

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SSN cannot be blank', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TECHNICIAN', @level2type = N'CONSTRAINT', @level2name = N'CK_TECHNICIAN';

