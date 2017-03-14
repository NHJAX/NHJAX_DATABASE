CREATE TABLE [dbo].[POP_HEALTH_CERVICAL] (
    [Annotation]      NVARCHAR (255) NULL,
    [PatientName]     NVARCHAR (255) NULL,
    [EDIPN]           NVARCHAR (255) NULL,
    [FMP]             NVARCHAR (255) NULL,
    [DOB]             NVARCHAR (255) NULL,
    [Age]             NVARCHAR (255) NULL,
    [BenCat]          NVARCHAR (255) NULL,
    [PCMName]         NVARCHAR (255) NULL,
    [ProviderGroup]   NVARCHAR (255) NULL,
    [PapLastExamDate] NVARCHAR (255) NULL,
    [PapSystem]       NVARCHAR (255) NULL,
    [PapSource]       NVARCHAR (255) NULL,
    [HpvLastExamDate] NVARCHAR (255) NULL,
    [HpvSystem]       NVARCHAR (255) NULL,
    [HpvSource]       NVARCHAR (255) NULL,
    [XLastExamDate]   NVARCHAR (255) NULL,
    [XSystem]         NVARCHAR (255) NULL,
    [XSource]         NVARCHAR (255) NULL,
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
    [ACGDate]         NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CERVICAL_EDIPN]
    ON [dbo].[POP_HEALTH_CERVICAL]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CERVICAL_FMP]
    ON [dbo].[POP_HEALTH_CERVICAL]([FMP] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_CERVICAL_PapLastExamDate]
    ON [dbo].[POP_HEALTH_CERVICAL]([PapLastExamDate] ASC) WITH (FILLFACTOR = 100);

