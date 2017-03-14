CREATE TABLE [dbo].[PROVIDER_HISTORY] (
    [ProviderId]          BIGINT          NULL,
    [ProviderKey]         NUMERIC (12, 4) NULL,
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
    [ProviderFlag]        BIT             NULL,
    [CreatedDate]         DATETIME        NULL,
    [UpdatedDate]         DATETIME        NULL,
    [DutyPhone]           VARCHAR (18)    NULL,
    [PagerNumber]         VARCHAR (18)    NULL,
    [PCMProjectedEndDate] VARCHAR (15)    NULL,
    [SourceSystemId]      BIGINT          NULL,
    [NPIKey]              NUMERIC (16, 3) NULL,
    [ENetId]              INT             NULL,
    [ENetLocationId]      BIGINT          NULL,
    [DoDEDI]              VARCHAR (50)    NULL,
    [SourceSystemKey]     VARCHAR (50)    NULL,
    [AltProviderId]       BIGINT          NULL,
    [PCMCodeId]           INT             NULL,
    [HistoryDate]         DATETIME        CONSTRAINT [DF_PROVIDER_HISTORY_HistoryDate] DEFAULT (getdate()) NULL
);


GO
CREATE CLUSTERED INDEX [IX_PROVIDER_HISTORY_HistoryDate]
    ON [dbo].[PROVIDER_HISTORY]([HistoryDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROVIDER_HISTORY_ProviderId]
    ON [dbo].[PROVIDER_HISTORY]([ProviderId] ASC);

