CREATE TABLE [dbo].[ASSET] (
    [AssetId]              INT            IDENTITY (1, 1) NOT NULL,
    [ModelId]              INT            CONSTRAINT [DF_ASSET_ModelId] DEFAULT ((1)) NOT NULL,
    [PlantAccountPrefix]   VARCHAR (50)   NULL,
    [PlantAccountNumber]   VARCHAR (50)   NULL,
    [NetworkName]          VARCHAR (100)  NULL,
    [SerialNumber]         VARCHAR (50)   NULL,
    [AcquisitionDate]      DATETIME       CONSTRAINT [DF_ASSET_AcquisitionDate] DEFAULT ('1/1/1900') NOT NULL,
    [MacAddress]           VARCHAR (50)   NULL,
    [Remarks]              VARCHAR (1000) NULL,
    [AssetDesc]            VARCHAR (100)  NULL,
    [WarrantyMonths]       INT            NULL,
    [UnitCost]             MONEY          CONSTRAINT [DF_ASSET_UnitCost] DEFAULT ((0)) NULL,
    [EqpMgtBarCode]        VARCHAR (20)   NULL,
    [ReqDocNumber]         VARCHAR (20)   NULL,
    [ProjectId]            INT            CONSTRAINT [DF_ASSET_ProjectId] DEFAULT ((13)) NOT NULL,
    [AssetTypeId]          INT            CONSTRAINT [DF_ASSET_AssetTypeId] DEFAULT ((0)) NOT NULL,
    [AssetSubtypeId]       INT            CONSTRAINT [DF_ASSET_AssetSubtypeId] DEFAULT ((0)) NOT NULL,
    [DepartmentId]         INT            CONSTRAINT [DF_ASSET_DepartmentId] DEFAULT ((0)) NOT NULL,
    [BuildingId]           INT            CONSTRAINT [DF_ASSET_BuildingId] DEFAULT ((5)) NOT NULL,
    [DeckId]               INT            CONSTRAINT [DF_ASSET_DeckId] DEFAULT ((9)) NOT NULL,
    [Room]                 VARCHAR (50)   CONSTRAINT [DF_ASSET_Room] DEFAULT ('n/a') NOT NULL,
    [MissionCritical]      BIT            CONSTRAINT [DF_ASSET_MissionCritical] DEFAULT ((1)) NOT NULL,
    [RemoteAccess]         BIT            CONSTRAINT [DF_ASSET_RemoteAccess] DEFAULT ((0)) NOT NULL,
    [OnLoan]               BIT            CONSTRAINT [DF_ASSET_OnLoan] DEFAULT ((0)) NOT NULL,
    [LeasedPurchased]      INT            CONSTRAINT [DF_ASSET_LeasedPurchased] DEFAULT ((0)) NOT NULL,
    [DispositionId]        INT            CONSTRAINT [DF_ASSET_DispositionId] DEFAULT ((0)) NOT NULL,
    [DomainId]             INT            CONSTRAINT [DF_ASSET_DomainId] DEFAULT ((0)) NOT NULL,
    [CreatedBy]            INT            CONSTRAINT [DF_ASSET_CreatedBy] DEFAULT ((0)) NOT NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_ASSET_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            INT            CONSTRAINT [DF_ASSET_UpdatedBy] DEFAULT ((0)) NOT NULL,
    [UpdatedDate]          DATETIME       CONSTRAINT [DF_ASSET_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    [InventoryDate]        DATETIME       CONSTRAINT [DF_ASSET_InventoryDate] DEFAULT ('01/01/1900') NOT NULL,
    [InventoryBy]          INT            CONSTRAINT [DF_ASSET_InventoryBy] DEFAULT ((0)) NULL,
    [PrinterConfig]        INT            CONSTRAINT [DF_ASSET_PrinterConfig] DEFAULT ((0)) NULL,
    [SharePC]              INT            CONSTRAINT [DF_ASSET_SharePC] DEFAULT ((0)) NULL,
    [MACAddress2]          VARCHAR (50)   NULL,
    [ManufacturerId]       INT            CONSTRAINT [DF_ASSET_ManufacturerId] DEFAULT ((324)) NULL,
    [AudienceId]           BIGINT         CONSTRAINT [DF_ASSET_AudienceId] DEFAULT ((0)) NULL,
    [UpdateSourceSystemId] INT            CONSTRAINT [DF_ASSET_SourceSystemId] DEFAULT ((0)) NULL,
    [LastChecked]          DATETIME       CONSTRAINT [DF_ASSET_LastChecked] DEFAULT (getdate()) NULL,
    [IsAIMException]       BIT            CONSTRAINT [DF_ASSET_IsAIMException] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ASSET] PRIMARY KEY CLUSTERED ([AssetId] ASC),
    CONSTRAINT [FK_ASSET_ASSET_SUBTYPE] FOREIGN KEY ([AssetSubtypeId]) REFERENCES [dbo].[ASSET_SUBTYPE] ([AssetSubTypeId]),
    CONSTRAINT [FK_ASSET_ASSET_TYPE] FOREIGN KEY ([AssetTypeId]) REFERENCES [dbo].[ASSET_TYPE] ([AssetTypeId]),
    CONSTRAINT [FK_ASSET_BUILDING] FOREIGN KEY ([BuildingId]) REFERENCES [dbo].[BUILDING] ([BuildingId]),
    CONSTRAINT [FK_ASSET_DECK] FOREIGN KEY ([DeckId]) REFERENCES [dbo].[DECK] ([DeckId]),
    CONSTRAINT [FK_ASSET_DEPARTMENT] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[DEPARTMENT_20080612] ([DepartmentId]),
    CONSTRAINT [FK_ASSET_DISPOSITION] FOREIGN KEY ([DispositionId]) REFERENCES [dbo].[DISPOSITION] ([DispositionId]),
    CONSTRAINT [FK_ASSET_DOMAIN] FOREIGN KEY ([DomainId]) REFERENCES [dbo].[DOMAIN] ([DomainId]),
    CONSTRAINT [FK_ASSET_MODEL] FOREIGN KEY ([ModelId]) REFERENCES [dbo].[MODEL] ([ModelId]),
    CONSTRAINT [FK_ASSET_PROJECT] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[PROJECT] ([ProjectId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET]
    ON [dbo].[ASSET]([DispositionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_AcquisitionDate]
    ON [dbo].[ASSET]([AcquisitionDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_AssetSubtypeId]
    ON [dbo].[ASSET]([AssetSubtypeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_AssetTypeId]
    ON [dbo].[ASSET]([AssetTypeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_AudienceId]
    ON [dbo].[ASSET]([AudienceId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_DepartmentId]
    ON [dbo].[ASSET]([DepartmentId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_DispositionId]
    ON [dbo].[ASSET]([DispositionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_DispositionId_NetworkName]
    ON [dbo].[ASSET]([NetworkName] ASC, [DispositionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_EqpMgtBarCode]
    ON [dbo].[ASSET]([EqpMgtBarCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_MacAddress]
    ON [dbo].[ASSET]([MacAddress] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_ManufacturerId]
    ON [dbo].[ASSET]([ManufacturerId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_ModelId]
    ON [dbo].[ASSET]([ModelId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_NetworkName]
    ON [dbo].[ASSET]([NetworkName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_PlantAccountNumber]
    ON [dbo].[ASSET]([PlantAccountNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_PlantAccountPrefix_PlantAccountNumber]
    ON [dbo].[ASSET]([PlantAccountPrefix] ASC, [PlantAccountNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_ProjectId]
    ON [dbo].[ASSET]([ProjectId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_SerialNumber]
    ON [dbo].[ASSET]([SerialNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ASSET_UpdatedDate]
    ON [dbo].[ASSET]([UpdatedDate] ASC);


GO
CREATE TRIGGER [dbo].[trENet_Asset_Update] ON dbo.ASSET
FOR UPDATE
AS


DECLARE @ast int
DECLARE @mod int
DECLARE @pre varchar(50)
DECLARE @num varchar(50)
DECLARE @net varchar(100)
DECLARE @ser varchar(50)
DECLARE @acq datetime
DECLARE @mac varchar(50)
DECLARE @rem varchar(1000)
DECLARE @desc varchar(100)
DECLARE @warr int
DECLARE @unit money
DECLARE @bar varchar(15)
DECLARE @req varchar(20)
DECLARE @proj int
DECLARE @atyp int
DECLARE @styp int
DECLARE @dept int
DECLARE @bldg int
DECLARE @deck int
DECLARE @rm varchar(50)
DECLARE @miss bit
DECLARE @acc bit
DECLARE @loan bit
DECLARE @lp int
DECLARE @disp int
DECLARE @dom int
DECLARE @cby int
DECLARE @cdate datetime
DECLARE @uby int
DECLARE @udate datetime
DECLARE @idate datetime
DECLARE @prt int
DECLARE @share int
DECLARE @mac2 varchar(50)
DECLARE @man int
DECLARE @aud bigint
DECLARE @src int
DECLARE @hby int

--Don't want the AIM generic updates to trigger

IF NOT UPDATE(UpdatedBy) AND NOT UPDATE(UpdatedDate)
BEGIN

	SELECT 
		@ast = AssetId,
		@mod = ModelId, 
		@pre = ISNULL(PlantAccountPrefix,''), 
		@num = ISNULL(PlantAccountNumber,''), 
		@net = ISNULL(NetworkName,''), 
		@ser = ISNULL(SerialNumber,''), 
		@acq = ISNULL(AcquisitionDate,'1/1/1900'), 
		@mac = ISNULL(MacAddress,''), 
		@rem = ISNULL(Remarks,''), 
		@desc = ISNULL(AssetDesc,''), 
		@warr = ISNULL(WarrantyMonths,0), 
		@unit = ISNULL(UnitCost,0),
		@bar = ISNULL(EqpMgtBarCode,''),
		@req = ISNULL(ReqDocNumber,''), 
		@proj = ProjectId, 
		@atyp = AssetTypeId, 
		@styp = AssetSubtypeId, 
		@dept = DepartmentId, 
		@bldg = BuildingId, 
		@deck = DeckId, 
		@rm = ISNULL(Room,''), 
		@miss = MissionCritical, 
		@acc = RemoteAccess, 
		@loan = OnLoan, 
		@lp = LeasedPurchased, 
		@disp = DispositionId, 
		@dom = DomainId, 
		@cby = CreatedBy, 
		@cdate = CreatedDate, 
		@uby = UpdatedBy, 
		@udate = UpdatedDate, 
		@idate = ISNULL(InventoryDate,'1/1/1900'), 
		@prt = PrinterConfig, 
		@share = SharePC, 
		@mac2 = ISNULL(MACAddress2,''), 
		@man = ManufacturerId, 
		@aud = ISNULL(AudienceId,0), 
		@src = ISNULL(UpdateSourceSystemId,0),
		@hby = UpdatedBy

	FROM deleted 

	--SELECT @hby = UpdatedBy
	--FROM deleted

	IF @disp > 0
		BEGIN
		INSERT INTO ASSET_HISTORY
		(
			AssetId, 
			ModelId, 
			PlantAccountPrefix, 
			PlantAccountNumber, 
			NetworkName, 
			SerialNumber, 
			AcquisitionDate, 
			MacAddress, 
			Remarks, 
			AssetDesc, 
			WarrantyMonths, 
			UnitCost, 
			EqpMgtBarCode, 
			ReqDocNumber, 
			ProjectId, 
			AssetTypeId, 
			AssetSubtypeId, 
			DepartmentId, 
			BuildingId, 
			DeckId, 
			Room, 
			MissionCritical, 
			RemoteAccess, 
			OnLoan, 
			LeasedPurchased, 
			DispositionId, 
			DomainId, 
			CreatedBy, 
			CreatedDate, 
			UpdatedBy, 
			UpdatedDate, 
			InventoryDate, 
			PrinterConfig, 
			SharePC, 
			MACAddress2, 
			ManufacturerId, 
			AudienceId, 
			UpdateSourceSystemId, 
			HistoryBy
		)
		VALUES     
		(
			@ast,
			@mod,
			@pre,
			@num,
			@net,
			@ser,
			@acq,
			@mac,
			@rem,
			@desc,
			@warr,
			@unit,
			@bar,
			@req,
			@proj,
			@atyp,
			@styp,
			@dept,
			@bldg,
			@deck,
			@rm,
			@miss,
			@acc,
			@loan,
			@lp,
			@disp,
			@dom,
			@cby,
			@cdate,
			@uby,
			@udate,
			@idate,
			@prt,
			@share,
			@mac2,
			@man,
			@aud,
			@src,
			@hby
		)
		END

END

GO
CREATE TRIGGER [dbo].[trENet_Asset_UpdateAudienceId] ON dbo.ASSET
FOR UPDATE
AS

DECLARE @dept int
DECLARE @deptnew int
DECLARE @ast int
DECLARE @aud bigint
Declare @exists int
DECLARE @flag bit 

--If it is not the departmentid changing, then only update if
--audienceid is not set

IF NOT UPDATE(DepartmentId)
	BEGIN
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('not updated')
		SET @flag = 1
	END
ELSE
	BEGIN
		SET @flag = 0
	END

SELECT @dept = AST.DepartmentId, @ast = AST.AssetId,
@deptnew = ASSET.AudienceId
FROM inserted AS AST
INNER JOIN ASSET 
ON AST.AssetId = ASSET.AssetId

If @deptnew IS NULL OR @deptnew = 0 OR @flag = 0
	BEGIN
		SELECT	TOP 1 @aud = AudienceId
		FROM	AUDIENCE
		WHERE	(OldDepartmentId = @dept)
		AND AudienceCategoryId = 3
		SET @exists = @@RowCount


		If @exists = 0 
			BEGIN
				UPDATE ASSET
				SET AudienceId = 0
				WHERE AssetId = @ast
			END
		ELSE
			BEGIN
				UPDATE ASSET
				SET AudienceId = @aud
				WHERE AssetId = @ast
			END
	END

GO
DISABLE TRIGGER [dbo].[trENet_Asset_UpdateAudienceId]
    ON [dbo].[ASSET];


GO
create TRIGGER [dbo].[trENet_Asset_UpdateDisposition_SoftwareStatus] ON dbo.ASSET
FOR UPDATE
AS

DECLARE @ast int
DECLARE @vwl int
DECLARE @asg int
DECLARE @prt int
DECLARE @afl bigint

SELECT @ast = AST.AssetId, @vwl = DISP.ViewLevelId
	FROM inserted AST
	INNER JOIN DISPOSITION DISP
	ON AST.DispositionId = DISP.DispositionId

DECLARE curAsg CURSOR FAST_FORWARD FOR
	SELECT AssignmentId
	FROM ASSET_ASSIGNMENT
	WHERE AssetId = @ast

OPEN curAsg

FETCH NEXT FROM curAsg INTO @asg

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF @vwl > 1
			BEGIN
		
				UPDATE ASSET_ASSIGNMENT
				SET Inactive = 1
				WHERE AssignmentId = @asg
				
			END
		ELSE
			BEGIN
		
				UPDATE ASSET_ASSIGNMENT
				SET Inactive = 0
				WHERE AssignmentId = @asg

			END
		FETCH NEXT FROM curAsg INTO @asg
	END
END

CLOSE curAsg
DEALLOCATE curAsg

DECLARE curPrt CURSOR FAST_FORWARD FOR
	SELECT AssetPrinterId
	FROM ASSET_PRINTER
	WHERE AssetId = @ast

OPEN curPrt

FETCH NEXT FROM curPrt INTO @prt

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF @vwl > 1
			BEGIN
		
				UPDATE ASSET_PRINTER
				SET Inactive = 1
				WHERE AssetPrinterId = @prt
		
			END
		ELSE
			BEGIN
				
				UPDATE ASSET_PRINTER
				SET Inactive = 0
				WHERE AssetPrinterId = @prt

			END
		FETCH NEXT FROM curPrt INTO @prt
	END
END

CLOSE curPrt
DEALLOCATE curPrt

DECLARE curAfl CURSOR FAST_FORWARD FOR
	SELECT AssetFileId
	FROM ASSET_FILE
	WHERE AssetId = @ast

OPEN curAfl

FETCH NEXT FROM curAfl INTO @afl

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF @vwl > 1
			BEGIN
				UPDATE ASSET_FILE
				SET Removed = 1
				WHERE AssetFileId = @afl
				
			END
		ELSE
			BEGIN
				UPDATE ASSET_FILE
				SET Removed = 0
				WHERE AssetFileId = @afl

			END
		FETCH NEXT FROM curAfl INTO @afl
	END
END

CLOSE curAfl
DEALLOCATE curAfl

IF @vwl > 1
	BEGIN
		DELETE FROM ASSET_MAC
		WHERE AssetId = @ast
	END

GO
CREATE TRIGGER [dbo].[ENET_Asset_Relocation]
   ON  [dbo].[ASSET]
   FOR UPDATE
AS 
DECLARE @rm varchar(103)
DECLARE @rmold varchar(103)
DECLARE @aud bigint
DECLARE @audold bigint
Declare @audolddesc varchar(50)
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @To varchar(200)
DECLARE @CC varchar(200)
DECLARE @ecn varchar(15)
DECLARE @nom varchar(101)
DECLARE @ser varchar(50)
DECLARE @mod varchar(101)
DECLARE @plant varchar(103)
DECLARE @auddesc varchar(50)
DECLARE @ast int
DECLARE @typ int


IF UPDATE(Room) OR UPDATE(AudienceId)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT @ast = ASSET.AssetId, 
	@ecn = ISNULL(ASSET.EqpMgtBarCode,'NULL'), 
	@nom = ISNULL(TYP.AssetTypeDesc,'NULL') + ' ' + ISNULL(SUB.AssetSubTypeDesc,'NULL'), 
	@ser = ISNULL(ASSET.SerialNumber,'NULL'), 
	@mod = ISNULL(MOD.ModelDesc,'NULL') + ' ' + ISNULL(MANF.ManufacturerDesc,'NULL'), 
	@plant = ISNULL(ASSET.PlantAccountPrefix,'NULL') + ' - ' + ISNULL(ASSET.PlantAccountNumber,'NULL'), 
	@rm = ISNULL(BLDG.BuildingDesc,'NULL') + ' - ' + ISNULL(ASSET.Room,'NULL'), 
	@auddesc = ISNULL(AUD.DisplayName,'NULL'), 
	@aud = ASSET.AudienceId,
	@typ = ASSET.AssetTypeId
FROM inserted AS ASSET 
	INNER JOIN AUDIENCE AS AUD 
	ON ASSET.AudienceId = AUD.AudienceId 
	INNER JOIN ASSET_TYPE AS TYP 
	ON ASSET.AssetTypeId = TYP.AssetTypeId 
	INNER JOIN ASSET_SUBTYPE AS SUB 
	ON ASSET.AssetSubtypeId = SUB.AssetSubTypeId 
	INNER JOIN MODEL AS MOD 
	ON ASSET.ModelId = MOD.ModelId 
	INNER JOIN MANUFACTURER AS MANF 
	ON MOD.ManufacturerId = MANF.ManufacturerId 
	INNER JOIN BUILDING AS BLDG 
	ON ASSET.BuildingId = BLDG.BuildingId
WHERE ASSET.DispositionId > 0 


SELECT @rmold = ISNULL(BLDG.BuildingDesc,'NULL') + ' - ' + ISNULL(ASSET.Room,'NULL'), 
	@audold = ASSET.AudienceId,
	@audolddesc = AUD.DisplayName
FROM deleted AS ASSET 
	INNER JOIN AUDIENCE AS AUD 
	ON ASSET.AudienceId = AUD.AudienceId 
	INNER JOIN BUILDING AS BLDG 
	ON ASSET.BuildingId = BLDG.BuildingId
WHERE ASSET.DispositionId > 0
	AND (DataLength(ASSET.EqpMgtBarCode) > 0 
	OR DataLength(ASSET.SerialNumber) > 0)

--Send Mail if room change and audience did not
If (@aud <> @audold AND DataLength(@aud) > 0 AND @typ <> 8)
	OR (@rm <> @rmold AND DataLength(@rm) > 0 AND @typ <> 8)
	BEGIN
		SET @To = 'usn.jacksonville.navhospjaxfl.list.equipment-relocation@mail.mil;'
		SET @Sub = '*** FOUO ***INTRA-DEPARTMENTAL EQUIPMENT RELOCATION'
		SET @CC = ''
		SET @Msg = 'An Asset was moved within NHJAX: '

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'ECN:'+ CHAR(9) + CHAR(9) + CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + @ecn

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'Nomenclature:'+ CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @nom

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'Serial Number:'+ CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + @ser

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'Model:'+ CHAR(9) + CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + @mod

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'Plant Number:'+ CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + @plant

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'From Room:'+ CHAR(9) + CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @rmold

		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'To Room:'+ CHAR(9) + CHAR(9)+ CHAR(9)
		SET @Msg = @Msg + @rm
		
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'From Department:'+ CHAR(9) + CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @audolddesc
		
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + 'to Department:'+ CHAR(9) + CHAR(9) + CHAR(9)
		SET @Msg = @Msg + @auddesc
		
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
		SET @Msg = @Msg + 'Asset:' + CHAR(9)
		SET @Msg = @Msg + CAST(@ast	AS varchar(10))

		EXEC dbo.procENET_SendMail_AssetRelocation @sub, @msg, @To, @CC

	END
END

GO
CREATE TRIGGER [dbo].[supressprinters] ON [dbo].[ASSET] 
FOR INSERT
AS
UPDATE ASSET
SET DispositionId = 9
WHERE DispositionId <> 9
AND (NetworkName LIKE '%FranklinCovey%'
	OR NetworkName LIKE '%ActiveTouch%'
	OR NetworkName LIKE '%Fax%'
	OR NetworkName LIKE '%(Copy 2)'
	OR NetworkName LIKE '%Symantec%'
	OR NetworkName LIKE '%Adobe%'
	OR NetworkName LIKE '%Acrobat%'
	OR NetworkName LIKE '%Microsoft Office Document Image Writer'
	OR NetworkName LIKE '%PaperPort%'
	OR NetworkName LIKE '%Corel%'
	OR NetworkName LIKE '%Journal Note Writer'
	OR NetworkName LIKE '%SMART Notebook%'
	OR NetworkName LIKE '%FlashPaper%'
	OR NetworkName LIKE '%PDF reDirect%'
	OR NetworkName LIKE '%Microsoft XPS Document Writer%')

GO
create TRIGGER [dbo].[trENet_Asset_InsertAudienceId] ON dbo.ASSET
FOR INSERT
AS

DECLARE @dept int
DECLARE @deptnew int
DECLARE @ast int
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
	SELECT @dept = AST.DepartmentId, @ast = AST.AssetId,
	@deptnew = ISNULL(AST.AudienceId,0)
	FROM inserted AS AST
	
	IF @deptnew = 0
		BEGIN
			SELECT	TOP 1 @aud = AudienceId
			FROM	AUDIENCE
			WHERE	(OldDepartmentId = @dept)
			AND AudienceCategoryId = 3
			SET @exists = @@RowCount


			If @exists = 0 
				BEGIN
					UPDATE ASSET
					SET AudienceId = 0
					WHERE AssetId = @ast
				END
			ELSE
				BEGIN
					UPDATE ASSET
					SET AudienceId = @aud
					WHERE AssetId = @ast
				END
		END
END

GO
DISABLE TRIGGER [dbo].[trENet_Asset_InsertAudienceId]
    ON [dbo].[ASSET];


GO
CREATE TRIGGER [dbo].[trENet_Asset_UpdateMovement] ON dbo.ASSET
FOR INSERT, UPDATE
AS


DECLARE @ast int
DECLARE @aud bigint
DECLARE @audnew bigint
DECLARE @cby int
DECLARE @src int
--Declare @exists int
--DECLARE @flag bit 

--If it is not the departmentid changing, then only update if
--audienceid is not set

IF UPDATE(AudienceId)
BEGIN

	SELECT @ast = AssetId,
		@audnew = AudienceId,
		@cby = UpdatedBy,
		@src = UpdateSourceSystemId
	FROM inserted 

	SELECT @aud = AudienceId
	FROM deleted
	
	IF (@aud IS NULL AND @audnew <> 30)
	BEGIN
		SET @aud = 30
	END

	If ((@aud = 0 OR @aud IS NULL) AND (@audnew = 0 OR @audnew IS NULL)) OR (@aud = @audnew)
		BEGIN
		--Do Nothing -- Declare/Set req'd by compiler.
		DECLARE @x int
		SET @x = 0
		END
		ELSE
		BEGIN
		INSERT INTO ASSET_MOVEMENT
		(
			AssetId,
			FromAudienceId,
			ToAudienceId,
			CreatedBy,
			SourceSystemId
		)
		VALUES
		(
			@ast,
			@aud,
			@audnew,
			@cby,
			@src
		)
	END

END
