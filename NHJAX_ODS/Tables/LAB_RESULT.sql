CREATE TABLE [dbo].[LAB_RESULT] (
    [LabResultId]        BIGINT          IDENTITY (1, 1) NOT NULL,
    [PatientId]          BIGINT          NULL,
    [LabTestId]          BIGINT          NULL,
    [OrderId]            BIGINT          NULL,
    [LabWorkElementId]   BIGINT          NULL,
    [TakenDate]          DATETIME        NULL,
    [EnterDate]          DATETIME        NULL,
    [CertifyDate]        DATETIME        NULL,
    [AppendDate]         DATETIME        NULL,
    [Result]             VARCHAR (19)    NULL,
    [UnitCost]           MONEY           NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_LAB_RESULT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]        DATETIME        CONSTRAINT [DF_LAB_RESULT_UpdatedDate] DEFAULT (getdate()) NULL,
    [LabResultKey]       NUMERIC (13, 3) NULL,
    [AccessionTypeId]    BIGINT          NULL,
    [LabResultSubKey]    NUMERIC (26, 9) NULL,
    [SourceSystemId]     INT             CONSTRAINT [DF_LAB_RESULT_SourceSystemId] DEFAULT ((2)) NULL,
    [Alert]              VARCHAR (5)     NULL,
    [EnterPersonId]      BIGINT          NULL,
    [CertifyPersonId]    BIGINT          NULL,
    [RNRDate]            DATETIME        NULL,
    [RNRPersonId]        BIGINT          CONSTRAINT [DF_LAB_RESULT_RNRPersonId] DEFAULT ((0)) NULL,
    [CollectionSampleId] BIGINT          NULL,
    [LogInDate]          DATETIME        NULL,
    [ResultComments]     VARCHAR (4000)  NULL,
    CONSTRAINT [PK_LAB_RESULT] PRIMARY KEY CLUSTERED ([LabResultId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PATIENT_LAB_TEST_KEY]
    ON [dbo].[LAB_RESULT]([PatientId] ASC, [LabTestId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_LabResultKey]
    ON [dbo].[LAB_RESULT]([LabResultKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_OrderId]
    ON [dbo].[LAB_RESULT]([OrderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_EnterDate]
    ON [dbo].[LAB_RESULT]([EnterDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_CertifyDate]
    ON [dbo].[LAB_RESULT]([CertifyDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_AppendDate]
    ON [dbo].[LAB_RESULT]([AppendDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_TakenDate]
    ON [dbo].[LAB_RESULT]([TakenDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_LoopSearch]
    ON [dbo].[LAB_RESULT]([LabTestId] ASC, [TakenDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_AccesionTypeId]
    ON [dbo].[LAB_RESULT]([AccessionTypeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_OrderId_LabTestId]
    ON [dbo].[LAB_RESULT]([LabTestId] ASC, [OrderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_MultiKey]
    ON [dbo].[LAB_RESULT]([PatientId] ASC, [LabTestId] ASC, [TakenDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_SourceSystemId]
    ON [dbo].[LAB_RESULT]([SourceSystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LAB_RESULT_LabTestId_LabResultKey]
    ON [dbo].[LAB_RESULT]([LabTestId] ASC, [LabResultKey] ASC);

