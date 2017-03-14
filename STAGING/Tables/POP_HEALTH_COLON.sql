CREATE TABLE [dbo].[POP_HEALTH_COLON] (
    [PatientName]     NVARCHAR (255) NULL,
    [EDIPN]           NVARCHAR (255) NULL,
    [FMP]             NVARCHAR (255) NULL,
    [DOB]             DATETIME       NULL,
    [Age]             FLOAT (53)     NULL,
    [BenCat]          NVARCHAR (255) NULL,
    [PCMName]         NVARCHAR (255) NULL,
    [ProviderGroup]   NVARCHAR (255) NULL,
    [ColonoscopyDate] NVARCHAR (255) NULL,
    [FlexSigmoidDate] NVARCHAR (255) NULL,
    [FOBTDate]        NVARCHAR (255) NULL,
    [DCBEDate]        NVARCHAR (255) NULL,
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
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_COLON_EDIPN]
    ON [dbo].[POP_HEALTH_COLON]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_COLON_FMP]
    ON [dbo].[POP_HEALTH_COLON]([FMP] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_COLON_ColonoscopyDate]
    ON [dbo].[POP_HEALTH_COLON]([ColonoscopyDate] ASC) WITH (FILLFACTOR = 100);

