CREATE TABLE [dbo].[PRESCRIPTION_FILL_DATE] (
    [PrescriptionFillDateId]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [PrescriptionFillDateKey] NUMERIC (8, 3)  NULL,
    [FillDate]                DATETIME        NULL,
    [PrescriptionActionId]    BIGINT          CONSTRAINT [DF_PRESCRIPTION_FILL_DATE_PrescriptionActionId] DEFAULT ((0)) NULL,
    [DispensedDate]           DATETIME        NULL,
    [CreatedDate]             DATETIME        CONSTRAINT [DF_PRESCRIPTION_REFILL_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]             DATETIME        CONSTRAINT [DF_PRESCRIPTION_REFILL_UpdatedDate] DEFAULT (getdate()) NULL,
    [PrescriptionDrugId]      BIGINT          NULL,
    [DaysSupply]              NUMERIC (10, 3) NULL,
    [PrescriptionId]          BIGINT          NULL,
    [LabelPrintDateTime]      DATETIME        NULL,
    [LoggedBy]                BIGINT          CONSTRAINT [DF_PRESCRIPTION_FILL_DATE_LoggedBy] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PRESCRIPTION_REFILL] PRIMARY KEY CLUSTERED ([PrescriptionFillDateId] ASC),
    CONSTRAINT [FK_PRESCRIPTION_FILL_DATE_PRESCRIPTION_ACTION] FOREIGN KEY ([PrescriptionActionId]) REFERENCES [dbo].[PRESCRIPTION_ACTION] ([PrescriptionActionId]),
    CONSTRAINT [FK_PRESCRIPTION_FILL_DATE_PRESCRIPTION_DRUG] FOREIGN KEY ([PrescriptionDrugId]) REFERENCES [dbo].[PRESCRIPTION_DRUG] ([PrescriptionDrugId])
);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_PrescriptionFillDateKey_PrescriptionDrugId]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([PrescriptionFillDateKey] ASC, [PrescriptionDrugId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_PrescriptionFillDateKey]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([PrescriptionFillDateKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_FillDate_PrescriptionDrugId]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([FillDate] ASC, [PrescriptionDrugId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_PrescriptionId]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([PrescriptionId] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_FillDate]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([FillDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_PrescriptionActionId]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([PrescriptionActionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_CreatedDate]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PRESCRIPTION_FILL_DATE_PrescriptionDrugId]
    ON [dbo].[PRESCRIPTION_FILL_DATE]([PrescriptionDrugId] ASC);

