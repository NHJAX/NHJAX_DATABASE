CREATE TABLE [dbo].[POP_HEALTH_ASTHMA] (
    [PatientName]     NVARCHAR (255) NULL,
    [EDIPN]           NVARCHAR (255) NULL,
    [FMP]             NVARCHAR (255) NULL,
    [DOB]             NVARCHAR (255) NULL,
    [Gender]          NVARCHAR (255) NULL,
    [Age]             NVARCHAR (255) NULL,
    [BenCat]          NVARCHAR (255) NULL,
    [PCMName]         NVARCHAR (255) NULL,
    [ProviderGroup]   NVARCHAR (255) NULL,
    [Hospitalization] NVARCHAR (255) NULL,
    [Outpatient]      NVARCHAR (255) NULL,
    [ERVisits]        NVARCHAR (255) NULL,
    [Dispensing]      NVARCHAR (255) NULL,
    [CtrlRxDate]      NVARCHAR (255) NULL,
    [CtrlDrugName]    NVARCHAR (255) NULL,
    [Steroid]         NVARCHAR (255) NULL,
    [SteroidRxDate]   NVARCHAR (255) NULL,
    [SpirometryDate]  NVARCHAR (255) NULL,
    [Street1]         NVARCHAR (255) NULL,
    [Street2]         NVARCHAR (255) NULL,
    [City]            NVARCHAR (255) NULL,
    [State]           NVARCHAR (255) NULL,
    [Zip]             NVARCHAR (255) NULL,
    [Country]         NVARCHAR (255) NULL,
    [HomePhone]       NVARCHAR (255) NULL,
    [WorkPhone]       NVARCHAR (255) NULL,
    [DMIS]            NVARCHAR (255) NULL,
    [ACGRub]          NVARCHAR (255) NULL,
    [ACGIBI]          NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_ASTHMA_EDIPN]
    ON [dbo].[POP_HEALTH_ASTHMA]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_ASTHMA_FMP]
    ON [dbo].[POP_HEALTH_ASTHMA]([FMP] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_ASTHMA_CtrlRxDate]
    ON [dbo].[POP_HEALTH_ASTHMA]([CtrlRxDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_ASTHMA_SteroidRxDate]
    ON [dbo].[POP_HEALTH_ASTHMA]([SteroidRxDate] ASC) WITH (FILLFACTOR = 100);

