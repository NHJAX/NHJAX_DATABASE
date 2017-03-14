CREATE TABLE [dbo].[LAB_RESULT_BACTERIOLOGY_TEST] (
    [LabResultBacteriologyTestId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [LabResultId]                 BIGINT          NULL,
    [LabTestId]                   BIGINT          NULL,
    [LabResultKey]                NUMERIC (13, 3) NULL,
    [LabResultSubKey]             NUMERIC (26, 9) NULL,
    [LabResultTestKey]            NUMERIC (10, 3) NULL,
    [GramStain]                   VARCHAR (5000)  NULL,
    [BacteriologyResult]          VARCHAR (5000)  NULL,
    [CreatedDate]                 DATETIME        CONSTRAINT [DF_LAB_RESULT_TEST_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                 DATETIME        CONSTRAINT [DF_LAB_RESULT_TEST_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_RESULT_TEST] PRIMARY KEY CLUSTERED ([LabResultBacteriologyTestId] ASC),
    CONSTRAINT [FK_LAB_RESULT_BACTERIOLOGY_TEST_LAB_RESULT] FOREIGN KEY ([LabResultId]) REFERENCES [dbo].[LAB_RESULT] ([LabResultId]),
    CONSTRAINT [FK_LAB_RESULT_BACTERIOLOGY_TEST_LAB_TEST] FOREIGN KEY ([LabTestId]) REFERENCES [dbo].[LAB_TEST] ([LabTestid])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LAB_RESULT_BACTERIOLOGY_TEST_LabResultId_LabTestId]
    ON [dbo].[LAB_RESULT_BACTERIOLOGY_TEST]([LabResultId] ASC, [LabTestId] ASC);

