CREATE TABLE [dbo].[PROVIDER] (
    [ProviderId]          BIGINT          IDENTITY (0, 1) NOT NULL,
    [ProviderKey]         NUMERIC (12, 4) CONSTRAINT [DF_PROVIDER_ProviderKey] DEFAULT ((-1)) NULL,
    [ProviderName]        VARCHAR (40)    NULL,
    [ProviderClassId]     BIGINT          NULL,
    [ProviderCode]        VARCHAR (30)    NULL,
    [ProviderSSN]         VARCHAR (30)    NULL,
    [TerminationDate]     DATETIME        NULL,
    [InactivationDate]    DATETIME        NULL,
    [LocationId]          BIGINT          NULL,
    [MilitaryGradeRankId] BIGINT          NULL,
    [ClinicId]            BIGINT          NULL,
    [DepartmentId]        BIGINT          NULL,
    [ProviderFlag]        BIT             CONSTRAINT [DF_PROVIDER_ProviderFlag] DEFAULT ((0)) NULL,
    [CreatedDate]         DATETIME        CONSTRAINT [DF_PROVIDER_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]         DATETIME        CONSTRAINT [DF_PROVIDER_UpdatedDate] DEFAULT (getdate()) NULL,
    [DutyPhone]           VARCHAR (18)    NULL,
    [PagerNumber]         VARCHAR (18)    NULL,
    [PCMProjectedEndDate] VARCHAR (15)    NULL,
    [SourceSystemId]      BIGINT          CONSTRAINT [DF_PROVIDER_SourceSystemId] DEFAULT ((2)) NULL,
    [NPIKey]              VARCHAR (20)    NULL,
    [ENetId]              INT             CONSTRAINT [DF_PROVIDER_ENetId] DEFAULT ((-1)) NULL,
    [ENetLocationId]      BIGINT          CONSTRAINT [DF_PROVIDER_ENetLocationId] DEFAULT ((-1)) NULL,
    [DoDEDI]              VARCHAR (50)    NULL,
    [SourceSystemKey]     VARCHAR (50)    NULL,
    [AltProviderId]       BIGINT          NULL,
    [PCMCodeId]           INT             CONSTRAINT [DF_PROVIDER_PCMCodeId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PROVIDER] PRIMARY KEY CLUSTERED ([ProviderId] ASC),
    CONSTRAINT [FK_PROVIDER_DEPARTMENT] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[DEPARTMENT] ([DepartmentId]),
    CONSTRAINT [FK_PROVIDER_HOSPITAL_LOCATION] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[HOSPITAL_LOCATION] ([HospitalLocationId]),
    CONSTRAINT [FK_PROVIDER_MILITARY_GRADE_RANK] FOREIGN KEY ([MilitaryGradeRankId]) REFERENCES [dbo].[MILITARY_GRADE_RANK] ([MilitaryGradeRankId]),
    CONSTRAINT [FK_PROVIDER_PROVIDER_CLASS] FOREIGN KEY ([ProviderClassId]) REFERENCES [dbo].[PROVIDER_CLASS] ([ProviderClassId])
);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_KEY]
    ON [dbo].[PROVIDER]([ProviderKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_ProviderSSN]
    ON [dbo].[PROVIDER]([ProviderSSN] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_ProviderName]
    ON [dbo].[PROVIDER]([ProviderName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_PROVIDERID_PROVIDERNAME]
    ON [dbo].[PROVIDER]([ProviderId] ASC, [ProviderName] ASC, [LocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_LocationId]
    ON [dbo].[PROVIDER]([LocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_ProviderFlag]
    ON [dbo].[PROVIDER]([ProviderFlag] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_SourceSystemId]
    ON [dbo].[PROVIDER]([SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_ProviderKey_SourceSystemId]
    ON [dbo].[PROVIDER]([ProviderKey] ASC, [SourceSystemId] ASC);


GO
create TRIGGER [dbo].[trODS_PROVIDER_Update] ON dbo.PROVIDER
FOR UPDATE
AS


DECLARE @pro	bigint
DECLARE @key	numeric(12,4)
DECLARE @name	varchar(40)
DECLARE @class	bigint
DECLARE @code	varchar(30)
DECLARE @ssn	varchar(30)
DECLARE @tdate	datetime
DECLARE @idate	datetime
DECLARE @loc	bigint
DECLARE	@grd	bigint
DECLARE @clin	bigint
DECLARE @dept	bigint
DECLARE @flg	bit
DECLARE @cdate	datetime
DECLARE @udate	datetime
DECLARE @dph	varchar(18)
DECLARE @pgr	varchar(18)
DECLARE @edate	varchar(15)
DECLARE @ss		bigint
DECLARE @npi	numeric(16,3)
DECLARE @usr	int
DECLARE @eloc	bigint
DECLARE @edi	varchar(50)
DECLARE @ssk	varchar(50)
DECLARE @alt	bigint
DECLARE	@pcm	int

	SELECT 
		@pro = ProviderId,
		@key = ProviderKey, 
		@name = ProviderName, 
		@class = ProviderClassId, 
		@code = ProviderCode, 
		@ssn = ProviderSSN, 
		@tdate = TerminationDate,
		@idate = InactivationDate,
		@loc = LocationId,
		@grd = MilitaryGradeRankId,
		@clin = ClinicId,
		@dept = DepartmentId,
		@flg = ProviderFlag,
		@cdate = CreatedDate, 
		@udate = UpdatedDate, 
		@dph = DutyPhone,
		@pgr = PagerNumber,
		@edate = PCMProjectedEndDate,
		@ss = SourceSystemId,
		@npi = NPIKey,
		@usr = ENetId,
		@eloc = ENetLocationId,
		@edi = DoDEDI,
		@ssk = SourceSystemKey,
		@alt = AltProviderId,
		@pcm = PCMCodeId
	FROM deleted 

		INSERT INTO PROVIDER_HISTORY
		(
			ProviderId, 
			ProviderKey, 
			ProviderName, 
			ProviderClassId, 
			ProviderCode, 
			ProviderSSN, 
			TerminationDate, 
			InactivationDate, 
			LocationId, 
			MilitaryGradeRankId, 
			ClinicId, 
            DepartmentId, 
			ProviderFlag, 
			CreatedDate, 
			UpdatedDate, 
			DutyPhone, 
			PagerNumber, 
			PCMProjectedEndDate, 
			SourceSystemId, 
			NPIKey, 
			ENetId, 
			ENetLocationId, 
			DoDEDI, 
            SourceSystemKey, 
			AltProviderId, 
			PCMCodeId
		)
		VALUES     
		(
			@pro,
			@key, 
			@name, 
			@class, 
			@code, 
			@ssn, 
			@tdate,
			@idate,
			@loc,
			@grd,
			@clin,
			@dept,
			@flg,
			@cdate, 
			@udate, 
			@dph,
			@pgr,
			@edate,
			@ss,
			@npi,
			@usr,
			@eloc,
			@edi,
			@ssk,
			@alt,
			@pcm
		)
