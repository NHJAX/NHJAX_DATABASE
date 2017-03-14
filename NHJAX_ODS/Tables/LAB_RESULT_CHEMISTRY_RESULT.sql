CREATE TABLE [dbo].[LAB_RESULT_CHEMISTRY_RESULT] (
    [LabResultChemistryResultId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [LabResultId]                BIGINT          NULL,
    [LabTestId]                  BIGINT          NULL,
    [LabResultKey]               NUMERIC (13, 3) NULL,
    [LabResultSubKey]            NUMERIC (26, 9) NULL,
    [LabResultResultKey]         NUMERIC (10, 3) NULL,
    [ChemistryResult]            VARCHAR (30)    NULL,
    [CreatedDate]                DATETIME        CONSTRAINT [DF_LAB_RESULT_CHEMISTRY_RESULT_CreatedDate] DEFAULT (getdate()) NULL,
    [UpdatedDate]                DATETIME        CONSTRAINT [DF_LAB_RESULT_CHEMISTRY_RESULT_UpdatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_LAB_RESULT_CHEMISTRY_RESULT] PRIMARY KEY CLUSTERED ([LabResultChemistryResultId] ASC),
    CONSTRAINT [FK_LAB_RESULT_CHEMISTRY_RESULT_LAB_RESULT] FOREIGN KEY ([LabResultChemistryResultId]) REFERENCES [dbo].[LAB_RESULT] ([LabResultId]),
    CONSTRAINT [FK_LAB_RESULT_CHEMISTRY_RESULT_LAB_TEST] FOREIGN KEY ([LabTestId]) REFERENCES [dbo].[LAB_TEST] ([LabTestid])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LAB_RESULT_CHEMISTRY_RESULT_MultiKey]
    ON [dbo].[LAB_RESULT_CHEMISTRY_RESULT]([LabResultId] ASC, [LabTestId] ASC);

