CREATE TABLE [dbo].[POP_HEALTH_DIABETES] (
    [Annotation]       NVARCHAR (255) NULL,
    [PatientName]      NVARCHAR (255) NULL,
    [EDIPN]            NVARCHAR (255) NULL,
    [FMP]              NVARCHAR (255) NULL,
    [DOB]              NVARCHAR (255) NULL,
    [Age]              NVARCHAR (255) NULL,
    [BenCat]           NVARCHAR (255) NULL,
    [PCMName]          NVARCHAR (255) NULL,
    [ProviderGroup]    NVARCHAR (255) NULL,
    [OutpatientVisits] NVARCHAR (255) NULL,
    [Hospitalizations] NVARCHAR (255) NULL,
    [ERVisits]         NVARCHAR (255) NULL,
    [RxCount]          NVARCHAR (255) NULL,
    [Insulin]          NVARCHAR (255) NULL,
    [TestName]         NVARCHAR (255) NULL,
    [A1CDate]          NVARCHAR (255) NULL,
    [A1CResult]        NVARCHAR (255) NULL,
    [RetinalDate]      NVARCHAR (255) NULL,
    [LDLCertDate]      NVARCHAR (255) NULL,
    [LDL]              NVARCHAR (255) NULL,
    [Col021]           NVARCHAR (255) NULL,
    [CHOLCertDate]     NVARCHAR (255) NULL,
    [CHOL]             NVARCHAR (255) NULL,
    [HDLCertDate]      NVARCHAR (255) NULL,
    [HDL]              NVARCHAR (255) NULL,
    [Chol-HDLRatio]    NVARCHAR (255) NULL,
    [Street1]          NVARCHAR (255) NULL,
    [Street2]          NVARCHAR (255) NULL,
    [City]             NVARCHAR (255) NULL,
    [State]            NVARCHAR (255) NULL,
    [Zip]              NVARCHAR (255) NULL,
    [Country]          NVARCHAR (255) NULL,
    [HomePhone]        NVARCHAR (255) NULL,
    [WorkPhone]        NVARCHAR (255) NULL,
    [DMIS]             NVARCHAR (255) NULL,
    [F36]              NVARCHAR (255) NULL,
    [ACGRUB]           NVARCHAR (255) NULL,
    [ACGIBI]           NVARCHAR (255) NULL,
    [ACGDate]          NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_EDIPN]
    ON [dbo].[POP_HEALTH_DIABETES]([EDIPN] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_FMP]
    ON [dbo].[POP_HEALTH_DIABETES]([FMP] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_A1CDate]
    ON [dbo].[POP_HEALTH_DIABETES]([A1CDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_RetinalDate]
    ON [dbo].[POP_HEALTH_DIABETES]([RetinalDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_LDLCertDate]
    ON [dbo].[POP_HEALTH_DIABETES]([LDLCertDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_CHOLCertDate]
    ON [dbo].[POP_HEALTH_DIABETES]([CHOLCertDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_POP_HEALTH_DIABETES_HDLCertDate]
    ON [dbo].[POP_HEALTH_DIABETES]([HDLCertDate] ASC) WITH (FILLFACTOR = 100);

