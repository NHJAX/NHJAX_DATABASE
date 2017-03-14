CREATE TABLE [dbo].[POP_HEALTH_MAMMOGRAPHY] (
    [Status]        NVARCHAR (255) NULL,
    [ACGRub]        NVARCHAR (255) NULL,
    [ACGIBI]        NVARCHAR (255) NULL,
    [PatientName]   NVARCHAR (255) NULL,
    [EDIPN]         NVARCHAR (255) NULL,
    [FMP]           NVARCHAR (255) NULL,
    [DOB]           DATETIME       NULL,
    [Age]           FLOAT (53)     NULL,
    [Gender]        NVARCHAR (255) NULL,
    [BenCat]        NVARCHAR (255) NULL,
    [PCMName]       NVARCHAR (255) NULL,
    [ProviderGroup] NVARCHAR (255) NULL,
    [LastExamDate]  NVARCHAR (255) NULL,
    [System]        NVARCHAR (255) NULL,
    [Source]        NVARCHAR (255) NULL,
    [Street1]       NVARCHAR (255) NULL,
    [Street2]       NVARCHAR (255) NULL,
    [City]          NVARCHAR (255) NULL,
    [State]         NVARCHAR (255) NULL,
    [Zip]           NVARCHAR (255) NULL,
    [Country]       NVARCHAR (255) NULL,
    [HomePhone]     NVARCHAR (255) NULL,
    [WorkPhone]     NVARCHAR (255) NULL,
    [DMIS]          NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_MAMMOGRAPHY_EDIPN]
    ON [dbo].[POP_HEALTH_MAMMOGRAPHY]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_MAMMOGRAPHY_FMP]
    ON [dbo].[POP_HEALTH_MAMMOGRAPHY]([FMP] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_MAMMOGRAPHY_LastExamDate]
    ON [dbo].[POP_HEALTH_MAMMOGRAPHY]([LastExamDate] ASC) WITH (FILLFACTOR = 100);

