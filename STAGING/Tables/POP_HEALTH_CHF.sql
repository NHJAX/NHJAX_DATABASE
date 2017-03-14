CREATE TABLE [dbo].[POP_HEALTH_CHF] (
    [PatientName]     NVARCHAR (255) NULL,
    [EDIPN]           NVARCHAR (255) NULL,
    [FMP]             NVARCHAR (255) NULL,
    [DOB]             NVARCHAR (255) NULL,
    [Age]             NVARCHAR (255) NULL,
    [BenCat]          NVARCHAR (255) NULL,
    [PCMName]         NVARCHAR (255) NULL,
    [ProviderGroup]   NVARCHAR (255) NULL,
    [Outpatient]      NVARCHAR (255) NULL,
    [Hospitalization] NVARCHAR (255) NULL,
    [ERVisits]        NVARCHAR (255) NULL,
    [Street1]         NVARCHAR (255) NULL,
    [Street2]         NVARCHAR (255) NULL,
    [City]            NVARCHAR (255) NULL,
    [State]           NVARCHAR (255) NULL,
    [Zip]             NVARCHAR (255) NULL,
    [Country]         NVARCHAR (255) NULL,
    [HomePhone]       NVARCHAR (255) NULL,
    [WorkPhone]       NVARCHAR (255) NULL,
    [DMIS]            NVARCHAR (255) NULL,
    [ACGRUB]          NVARCHAR (255) NULL,
    [ACGIBI]          NVARCHAR (255) NULL,
    [ACGDate]         NVARCHAR (255) NULL,
    [BPDate]          NVARCHAR (255) NULL,
    [Systolic]        NVARCHAR (255) NULL,
    [Diastolic]       NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CHF_EDIPN]
    ON [dbo].[POP_HEALTH_CHF]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CHF_FMP]
    ON [dbo].[POP_HEALTH_CHF]([FMP] ASC) WITH (FILLFACTOR = 100);

