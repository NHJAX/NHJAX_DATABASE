CREATE TABLE [dbo].[DRUG] (
    [DrugId]               BIGINT          IDENTITY (1, 1) NOT NULL,
    [DrugKey]              NUMERIC (13, 3) CONSTRAINT [DF_DRUG_DrugKey] DEFAULT ((0)) NULL,
    [DrugDesc]             VARCHAR (41)    NULL,
    [NDCNumber]            VARCHAR (15)    NULL,
    [Package]              VARCHAR (15)    NULL,
    [DrugUnit]             INT             NULL,
    [FSSPrice]             MONEY           NULL,
    [PricePerUnit]         MONEY           NULL,
    [PDTSUnitCost]         MONEY           NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_DRUG_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_DRUG_UpdatedDate] DEFAULT (getdate()) NULL,
    [SourceSystemId]       BIGINT          NULL,
    [LabelPrintName]       VARCHAR (40)    NULL,
    [MetricUnit]           VARCHAR (15)    NULL,
    [DrugScheduleCode]     VARCHAR (1)     NULL,
    [AHFSClassificationId] BIGINT          CONSTRAINT [DF_DRUG_AHFSClassificationId] DEFAULT ((0)) NULL,
    [TherapeuticClassId]   BIGINT          CONSTRAINT [DF_DRUG_TherapeuticClassId] DEFAULT ((0)) NULL,
    [DosageStrength]       NUMERIC (20, 5) NULL,
    [DrugRouteId]          BIGINT          NULL,
    [DrugFormId]           BIGINT          NULL,
    CONSTRAINT [PK_DRUG] PRIMARY KEY CLUSTERED ([DrugId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_KEY]
    ON [dbo].[DRUG]([DrugKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_DrugId,DrugKey,NDCNumber,Package,DrugUnit,FSSPrice,PricePerUnit,PDTSUnitCost,CreatedDate,Updateddate]
    ON [dbo].[DRUG]([DrugId] ASC, [DrugKey] ASC, [DrugDesc] ASC, [NDCNumber] ASC, [Package] ASC, [DrugUnit] ASC, [FSSPrice] ASC, [PricePerUnit] ASC, [PDTSUnitCost] ASC, [CreatedDate] ASC, [UpdatedDate] ASC, [SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_DrugDesc]
    ON [dbo].[DRUG]([DrugDesc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_DrugId,DrugDesc]
    ON [dbo].[DRUG]([DrugId] ASC, [DrugDesc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_DrugScheduleCode]
    ON [dbo].[DRUG]([DrugDesc] ASC, [DrugScheduleCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_AHFSClassificationId]
    ON [dbo].[DRUG]([AHFSClassificationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_TherapeuticClassId]
    ON [dbo].[DRUG]([TherapeuticClassId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DRUG_AHFSClassificationId_TherapeuticClassId]
    ON [dbo].[DRUG]([AHFSClassificationId] ASC, [TherapeuticClassId] ASC);

