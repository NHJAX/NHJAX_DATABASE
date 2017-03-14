CREATE TABLE [dbo].[POP_HEALTH_CHLAMYDIA] (
    [Patient Name]   NVARCHAR (255) NULL,
    [EDIPN]          NVARCHAR (255) NULL,
    [FMP]            NVARCHAR (255) NULL,
    [DOB]            DATETIME       NULL,
    [Age]            FLOAT (53)     NULL,
    [BenCat]         NVARCHAR (255) NULL,
    [PCM Name]       NVARCHAR (255) NULL,
    [Provider Group] NVARCHAR (255) NULL,
    [Last Exam Date] NVARCHAR (255) NULL,
    [System]         NVARCHAR (255) NULL,
    [Source]         NVARCHAR (255) NULL,
    [ Street 1]      NVARCHAR (255) NULL,
    [Street 2]       NVARCHAR (255) NULL,
    [City]           NVARCHAR (255) NULL,
    [State]          NVARCHAR (255) NULL,
    [Zip]            NVARCHAR (255) NULL,
    [Country]        NVARCHAR (255) NULL,
    [Home Phone]     NVARCHAR (255) NULL,
    [Work Phone]     NVARCHAR (255) NULL,
    [DMIS]           FLOAT (53)     NULL,
    [ACGRUB]         NVARCHAR (255) NULL,
    [ACGIBI]         NVARCHAR (255) NULL,
    [ACGDate]        NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CHLAMYDIA_EDIPN]
    ON [dbo].[POP_HEALTH_CHLAMYDIA]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CHLAMYDIA_FMP]
    ON [dbo].[POP_HEALTH_CHLAMYDIA]([FMP] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CHLAMYDIA_LastExamDate]
    ON [dbo].[POP_HEALTH_CHLAMYDIA]([Last Exam Date] ASC) WITH (FILLFACTOR = 100);

